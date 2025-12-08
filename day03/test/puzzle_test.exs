# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  @tag focus: true
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 357
  end

  @tag focus: true
  test "line_joltage" do
    assert Puzzle.line_joltage("987654321111111") == 98
    assert Puzzle.line_joltage("811111111111119") == 89
    assert Puzzle.line_joltage("234234234234278") == 78
    assert Puzzle.line_joltage("818181911112111") == 92
  end

  @tag focus: true
  test "highest_digit_and_pos" do
    assert Puzzle.highest_digit_and_pos("9") == {"9", 0}
    assert Puzzle.highest_digit_and_pos("123456789") == {"9", 8}
    assert Puzzle.highest_digit_and_pos("22") == {"2", 0}
    assert Puzzle.highest_digit_and_pos("23453") == {"5", 3}
  end
end
