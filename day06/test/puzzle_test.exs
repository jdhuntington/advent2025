# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"]))
          |> String.split("\n", trim: false)

  # @tag focus: true
  test "part1 sample" do
    assert Puzzle.part1(@sample) == 4_277_556
  end

  @tag focus: true
  test "part2 sample" do
    assert Puzzle.part2(@sample) == 3_263_827
  end

  test "split_line" do
    assert Puzzle.split_line("1  2   3 4 5 6             ") == ["1", "2", "3", "4", "5", "6"]
  end

  # @tag focus: true
  test "process problems (simple)" do
    assert Puzzle.process_problems([["1"], ["+"]], &Puzzle.part1_extractor/2) == [1]
    assert Puzzle.process_problems([["1"], ["*"]], &Puzzle.part1_extractor/2) == [1]
    assert Puzzle.process_problems([["1"], ["1"], ["+"]], &Puzzle.part1_extractor/2) == [2]
    assert Puzzle.process_problems([["1"], ["1"], ["*"]], &Puzzle.part1_extractor/2) == [1]
  end

  @tag xfocus: true
  test "process problems (parts)" do
    assert Puzzle.process_problems([["1"], ["+"]], &Puzzle.part2_extractor/2) == [1]
    assert Puzzle.process_problems([["1"], ["*"]], &Puzzle.part2_extractor/2) == [1]
    assert Puzzle.process_problems([["1"], ["1"], ["+"]], &Puzzle.part2_extractor/2) == [2]
    assert Puzzle.process_problems([["1"], ["1"], ["*"]], &Puzzle.part2_extractor/2) == [1]
  end

  test "parse operand line" do
    assert Puzzle.parse_operand_line("*   +   *   +") == [0, 4, 8, 12]
    assert Puzzle.parse_operand_line("* + * +") == [0, 2, 4, 6]
  end

  @tag focus: true
  test "parse sample input" do
    assert Puzzle.parse_puzzle(@sample) == [
             ["123", "328", " 51", "64 "],
             [" 45", "64 ", "387", "23 "],
             ["  6", "98 ", "215", "314"],
             ["*  ", "+  ", "*  ", "+  "]
           ]
  end

  @tag focus: true
  test "part2 extractor" do
    assert Puzzle.part2_extractor(
             [
               ["123", "328", " 51", "64 "],
               [" 45", "64 ", "387", "23 "],
               ["  6", "98 ", "215", "314"]
             ],
             0
           ) == [356, 24, 1]

    assert Puzzle.part2_extractor(
             [
               ["123", "328", " 51", "64 "],
               [" 45", "64 ", "387", "23 "],
               ["  6", "98 ", "215", "314"]
             ],
             1
           ) ==
             [8, 248, 369]

    assert Puzzle.part2_extractor(
             [
               ["123", "328", " 51", "64 "],
               [" 45", "64 ", "387", "23 "],
               ["  6", "98 ", "215", "314"]
             ],
             2
           ) ==
             [175, 581, 32]

    assert Puzzle.part2_extractor(
             [
               ["123", "328", " 51", "64 "],
               [" 45", "64 ", "387", "23 "],
               ["  6", "98 ", "215", "314"]
             ],
             3
           ) ==
             [4, 431, 623]
  end
end
