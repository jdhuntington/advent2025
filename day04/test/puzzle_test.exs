# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  # @tag focus: true
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 13
  end

  @tag focus: true
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
end
