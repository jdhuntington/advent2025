# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  @tag focus: true
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 3
  end

  @tag focus: true
  test "part2 sample" do
    assert Puzzle.part2(@sample) == 14
  end

  # @tag focus: true
  test "insert range into ranges" do
    assert Puzzle.insert_range_into_ranges(Range.new(1, 3), [Range.new(1, 3)]) == [
             Range.new(1, 3)
           ]
  end

  test "load_ingredients" do
    assert Puzzle.load_ingredients(["1-2", "", "1"]) == %{ranges: [1..2], ingredients: [1]}
  end

  test "is_fresh?" do
    assert Puzzle.is_fresh?(5, [3..5])
    refute Puzzle.is_fresh?(6, [3..5])
    refute Puzzle.is_fresh?(2, [3..5])
    assert Puzzle.is_fresh?(3, [3..5])

    refute Puzzle.is_fresh?(0, [1..5, 7..8])
    assert Puzzle.is_fresh?(1, [1..5, 7..8])
    assert Puzzle.is_fresh?(2, [1..5, 7..8])
    assert Puzzle.is_fresh?(3, [1..5, 7..8])
    assert Puzzle.is_fresh?(4, [1..5, 7..8])
    assert Puzzle.is_fresh?(5, [1..5, 7..8])
    refute Puzzle.is_fresh?(6, [1..5, 7..8])
    assert Puzzle.is_fresh?(7, [1..5, 7..8])
    assert Puzzle.is_fresh?(8, [1..5, 7..8])
    refute Puzzle.is_fresh?(9, [1..5, 7..8])
  end
end
