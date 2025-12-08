# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  test "part1 sample" do
    assert Puzzle.part1(@sample) == 357
  end

  @tag focus: true
  test "part2 sample" do
    assert Puzzle.part2(@sample) == 3_121_910_778_619
  end

  test "part1 line_joltage" do
    assert Puzzle.part1_line_joltage("987654321111111") == 98
    assert Puzzle.part1_line_joltage("811111111111119") == 89
    assert Puzzle.part1_line_joltage("234234234234278") == 78
    assert Puzzle.part1_line_joltage("818181911112111") == 92
  end

  test "highest_digit_and_pos" do
    assert Puzzle.highest_digit_and_pos("9") == {"9", 0}
    assert Puzzle.highest_digit_and_pos("123456789") == {"9", 8}
    assert Puzzle.highest_digit_and_pos("22") == {"2", 0}
    assert Puzzle.highest_digit_and_pos("23453") == {"5", 3}
  end

  @tag focus: true
  test "part2 line_joltage" do
    assert Puzzle.part2_line_joltage("987654321111111") == 987_654_321_111
    assert Puzzle.part2_line_joltage("811111111111119") == 811_111_111_119
    assert Puzzle.part2_line_joltage("234234234234278") == 434_234_234_278
    assert Puzzle.part2_line_joltage("818181911112111") == 888_911_112_111
  end
end
