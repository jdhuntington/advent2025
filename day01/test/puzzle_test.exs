defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  test "part1 sample" do
    assert Puzzle.part1(@sample) == 3
  end

  test "parse R2" do
    assert Puzzle.parse_line("R2") == {:right, 2}
  end

  test "parse L999" do
    assert Puzzle.parse_line("L999") == {:left, 999}
  end

  test "transform simple right" do
    assert Puzzle.transform({:right, 2}, {50, 0}) == {52, 0}
  end

  test "transform simple left" do
    assert Puzzle.transform({:left, 2}, {50, 0}) == {48, 0}
  end

  test "transform doesn't return negative numbers" do
    assert Puzzle.transform({:left, 1}, {0, 0}) == {99, 0}
    assert Puzzle.transform({:left, 2}, {1, 0}) == {99, 0}
    assert Puzzle.transform({:left, 4}, {2, 0}) == {98, 0}
    assert Puzzle.transform({:right, 3}, {98, 0}) == {1, 0}
  end

  test "transform catches hits" do
    assert Puzzle.transform({:left, 0}, {0, 0}) == {0, 1}
    assert Puzzle.transform({:left, 1}, {1, 0}) == {0, 1}
    assert Puzzle.transform({:right, 50}, {50, 1}) == {0, 2}
  end

  test "process inputs processes a list correctly" do
    assert Puzzle.run({99, 0}, [{:right, 1}, {:right, 2}, {:left, 1}, {:left, 1}]) ==
             {0, 2}
  end
end
