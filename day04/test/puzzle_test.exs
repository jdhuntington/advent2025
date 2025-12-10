# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  test "part1 sample" do
    assert Puzzle.part1(@sample) == 13
  end

  test "count movable rows" do
    assert Puzzle.count_movable_rolls([[:empty]]) == 0
    assert Puzzle.count_movable_rolls([[:roll]]) == 1
  end

  test "is movable, basic" do
    assert Puzzle.is_movable(
             [
               [:empty, :empty, :empty],
               [:empty, :roll, :empty],
               [:empty, :empty, :empty]
             ],
             1,
             1
           )
  end

  test "is_movable_for_coordinates == true, basic" do
    assert Puzzle.is_movable_for_coordinates(
             [
               %{value: :empty, x: 0, y: 0},
               %{value: :empty, x: 1, y: 0},
               %{value: :empty, x: 2, y: 0},
               %{value: :empty, x: 0, y: 1},
               %{value: :roll, x: 1, y: 1},
               %{value: :empty, x: 2, y: 1},
               %{value: :roll, x: 0, y: 2},
               %{value: :roll, x: 1, y: 2},
               %{value: :roll, x: 2, y: 2}
             ],
             1,
             1
           )
  end

  test "is_movable_for_coordinates == false, basic" do
    refute Puzzle.is_movable_for_coordinates(
             [
               %{value: :empty, x: 0, y: 0},
               %{value: :roll, x: 1, y: 0},
               %{value: :roll, x: 2, y: 0},
               %{value: :empty, x: 0, y: 1},
               %{value: :roll, x: 1, y: 1},
               %{value: :empty, x: 2, y: 1},
               %{value: :roll, x: 0, y: 2},
               %{value: :roll, x: 1, y: 2},
               %{value: :roll, x: 2, y: 2}
             ],
             1,
             1
           )
  end

  test "is movable, edge case of 2" do
    assert Puzzle.is_movable(
             [
               [:empty, :empty, :empty],
               [:roll, :roll, :empty],
               [:empty, :roll, :empty]
             ],
             1,
             1
           )
  end

  test "is movable, edge case of 3" do
    assert Puzzle.is_movable(
             [
               [:empty, :roll, :empty],
               [:roll, :roll, :empty],
               [:empty, :roll, :empty]
             ],
             1,
             1
           )
  end

  test "is not movable, edge case of 4" do
    refute Puzzle.is_movable(
             [
               [:empty, :roll, :empty],
               [:roll, :roll, :roll],
               [:empty, :roll, :empty]
             ],
             1,
             1
           )
  end

  test "is not movable, 3x3" do
    refute Puzzle.is_movable(
             [
               [:empty, :roll, :roll],
               [:empty, :roll, :empty],
               [:roll, :roll, :roll]
             ],
             1,
             1
           )
  end

  test "is not movable, 2x3" do
    refute Puzzle.is_movable(
             [
               [:roll, :roll, :roll],
               [:roll, :roll, :roll]
             ],
             1,
             1
           )
  end

  test "parse a set of rows" do
    assert Puzzle.parse_input(["."]) == [[:empty]]
    assert Puzzle.parse_input(["@"]) == [[:roll]]
    assert Puzzle.parse_input([".@"]) == [[:empty, :roll]]
    assert Puzzle.parse_input([".", "@"]) == [[:empty], [:roll]]
    assert Puzzle.parse_input(@sample)
  end

  test "with coordinates" do
    layout = [
      [:empty, :roll, :roll],
      [:empty, :roll, :empty],
      [:roll, :roll, :roll]
    ]

    assert Puzzle.with_coordinates(layout) == [
             %{value: :empty, x: 0, y: 0},
             %{value: :roll, x: 1, y: 0},
             %{value: :roll, x: 2, y: 0},
             %{value: :empty, x: 0, y: 1},
             %{value: :roll, x: 1, y: 1},
             %{value: :empty, x: 2, y: 1},
             %{value: :roll, x: 0, y: 2},
             %{value: :roll, x: 1, y: 2},
             %{value: :roll, x: 2, y: 2}
           ]
  end
end
