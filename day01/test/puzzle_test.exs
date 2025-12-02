defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  test "part1 sample" do
    assert Puzzle.part1(@sample) == 3
  end

  test "part2 sample" do
    assert Puzzle.part2(@sample) == 6
  end

  test "parse R2" do
    assert Puzzle.parse_line("R2") == {:right, 2}
  end

  test "parse L999" do
    assert Puzzle.parse_line("L999") == {:left, 999}
  end

  test "transform simple right" do
    assert Puzzle.transform({:right, 2}, {50, 0, 0}) == {52, 0, 0}
  end

  test "transform simple left" do
    assert Puzzle.transform({:left, 2}, {50, 0, 0}) == {48, 0, 0}
  end

  test "transform doesn't return negative numbers" do
    assert Puzzle.transform({:left, 1}, {0, 0, 0}) == {99, 0, 0}
    assert Puzzle.transform({:left, 2}, {1, 0, 0}) == {99, 0, 1}
    assert Puzzle.transform({:left, 4}, {2, 0, 0}) == {98, 0, 1}
    assert Puzzle.transform({:right, 3}, {98, 0, 0}) == {1, 0, 1}
  end

  test "transform catches hits" do
    assert Puzzle.transform({:left, 1}, {1, 0, 0}) == {0, 1, 1}
    assert Puzzle.transform({:right, 50}, {50, 1, 0}) == {0, 2, 1}
  end

  test "transform catches passes_and_hits" do
    assert Puzzle.transform({:left, 1}, {1, 0, 0}) == {0, 1, 1}
    assert Puzzle.transform({:right, 50}, {50, 1, 1}) == {0, 2, 2}
    assert Puzzle.transform({:right, 100}, {50, 1, 1}) == {50, 1, 2}
    assert Puzzle.transform({:right, 200}, {50, 1, 1}) == {50, 1, 3}
    assert Puzzle.transform({:left, 200}, {50, 1, 1}) == {50, 1, 3}
    assert Puzzle.transform({:left, 100}, {50, 1, 1}) == {50, 1, 2}
    assert Puzzle.transform({:left, 50}, {2, 1, 1}) == {52, 1, 2}
  end

  test "process inputs processes a list correctly" do
    assert Puzzle.run([{:right, 1}, {:right, 2}, {:left, 1}, {:left, 1}], {99, 0, 0}) == {0, 2, 2}
  end

  @tag :focus
  test "pass_count" do
    assert 1 = Puzzle.pass_count(10, -20)
    assert 1 = Puzzle.pass_count(10, -109)
    assert 2 = Puzzle.pass_count(10, -110)
    assert 1 = Puzzle.pass_count(0, -100)
    assert 2 = Puzzle.pass_count(0, -200)
    assert 3 = Puzzle.pass_count(0, -300)
    assert 3 = Puzzle.pass_count(0, -399)
    assert 1 = Puzzle.pass_count(90, 20)
    assert 2 = Puzzle.pass_count(90, 120)
    assert 0 = Puzzle.pass_count(0, 99)
    assert 1 = Puzzle.pass_count(0, 100)
    assert 1 = Puzzle.pass_count(0, 101)
    assert 1 = Puzzle.pass_count(0, 199)
    assert 2 = Puzzle.pass_count(0, 200)
    assert 2 = Puzzle.pass_count(1, 200)
    assert 3 = Puzzle.pass_count(1, 299)
  end
end
