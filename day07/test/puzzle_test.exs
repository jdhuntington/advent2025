# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  @tag focus: true
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 21
  end

  @tag focus: true
  test "initial row" do
    assert Puzzle.tick(".......S.......", "...............") == %{
             splits: 0,
             state: ".......|......."
           }
  end

  @tag focus: true
  test "row with a splitter" do
    assert Puzzle.tick(".......|.......", ".......^.......") == %{
             splits: 1,
             state: "......|^|......"
           }
  end

  @tag focus: true
  test "row with an unused splitter" do
    assert Puzzle.tick("...............", ".......^.......") == %{
             splits: 0,
             state: ".......^......."
           }
  end

  @tag focus: true
  test "row with an unused splitter and a used splitter" do
    assert Puzzle.tick(".......|.......", ".^.....^.......") == %{
             splits: 1,
             state: ".^....|^|......"
           }
  end

  @tag focus: true
  test "calc_next_accumulated_value - basic" do
    assert Puzzle.calc_next_accumulated_value({".", 0}, %{splits: 0, state: ""}, ".", ".") ==
             %{splits: 0, state: "."}

    assert Puzzle.calc_next_accumulated_value({".", 0}, %{splits: 0, state: ""}, "|", ".") ==
             %{splits: 0, state: "|"}
  end

  @tag focus: true
  test "calc_next_accumulated_value - split" do
    assert Puzzle.calc_next_accumulated_value({".", 0}, %{splits: 0, state: ""}, ".|", ".^") ==
             %{splits: 0, state: "|"}

    assert Puzzle.calc_next_accumulated_value({"^", 0}, %{splits: 0, state: ""}, "|.", "^.") ==
             %{splits: 1, state: "^"}

    assert Puzzle.calc_next_accumulated_value({".", 1}, %{splits: 1, state: "^"}, "|.", "^.") ==
             %{splits: 1, state: "^|"}
  end
end
