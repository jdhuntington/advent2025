defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  test "part1 sample" do
    assert Puzzle.part1(@sample) == 142
  end

  @tag pending: true
  test "line_to_number" do
    assert Puzzle.line_to_number("a1b2c") == 12
  end
end
