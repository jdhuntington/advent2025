defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  @tag :pending
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 3
  end

  @tag :pending
  test "parse R2" do
    assert Puzzle.parse_line("R2") == {:right, 2}
  end

  @tag :pending
  test "parse L999" do
    assert Puzzle.parse_line("L999") == {:left, 999}
  end

  @tag :pending
  test "transform simple right" do
    assert Puzzle.transform({50, 0}, {:right, 2}) == {52, 0}
  end

  @tag :pending
  test "transform simple left" do
    assert Puzzle.transform({50, 0}, {:left, 2}) == {48, 0}
  end

  @tag :pending
  test "transform doesn't return negative numbers" do
    assert Puzzle.transform({0, 0}, {:left, 1}) == {99, 0}
    assert Puzzle.transform({1, 0}, {:left, 2}) == {99, 0}
    assert Puzzle.transform({2, 0}, {:left, 4}) == {98, 0}
    assert Puzzle.transform({98, 0}, {:right, 3}) == {1, 0}
  end

  @tag :pending
  test "transform catches hits" do
    assert Puzzle.transform({0, 0}, {:left, 0}) == {0, 1}
    assert Puzzle.transform({1, 0}, {:left, 1}) == {0, 1}
    assert Puzzle.transform({50, 1}, {:right, 50}) == {0, 2}
  end

  @tag :pending
  test "process inputs processes a list correctly" do
    assert Puzzle.run({99, 0}, [{:right, 1}, {:right, 2}, {:left, 1}, {:left, 1}]) ==
             {0, 2}
  end
end
