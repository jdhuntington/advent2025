# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  @tag focus: true
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 4_277_556
  end

  @tag focus: true
  test "part2 sample" do
    assert Puzzle.part1(@sample) == 3_263_827
  end

  test "split_line" do
    assert Puzzle.split_line("1  2   3 4 5 6             ") == ["1", "2", "3", "4", "5", "6"]
  end

  @tag focus: true
  test "process promblems (simple)" do
    assert Puzzle.process_problems([["1"], ["+"]]) == [1]
    assert Puzzle.process_problems([["1"], ["*"]]) == [1]
    assert Puzzle.process_problems([["1"], ["1"], ["+"]]) == [2]
    assert Puzzle.process_problems([["1"], ["1"], ["*"]]) == [1]
  end
end
