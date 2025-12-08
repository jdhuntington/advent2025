# `mix test --only focus`
defmodule PuzzleTest do
  use ExUnit.Case, async: true
  doctest Puzzle

  @sample File.read!(Path.join([__DIR__, "../priv/sample.txt"])) |> String.split("\n", trim: true)

  test "part1 sample" do
    assert Puzzle.part1(@sample) == 1_227_775_554
  end

  test "id1_valid? 11" do
    refute Puzzle.id1_valid?("11")
  end

  test "id1_valid? 55" do
    refute Puzzle.id1_valid?("55")
  end

  test "id1_valid? 6464" do
    refute Puzzle.id1_valid?("6464")
  end

  test "id1_valid? 123123" do
    refute Puzzle.id1_valid?("123123")
  end

  test "id1_valid? 1221" do
    assert Puzzle.id1_valid?("1221")
  end

  test "id1_valid? 101" do
    assert Puzzle.id1_valid?("101")
  end

  test "id1_valid? 1188511885" do
    refute Puzzle.id1_valid?("1188511885")
  end

  # ----- part two
  test "part2 sample" do
    assert Puzzle.part2(@sample) == 4_174_379_265
  end

  @tag focus: true
  test "id2_valid" do
    invalid_ids = [
      11,
      22,
      99,
      111,
      999,
      1010,
      1_188_511_885,
      222_222,
      446_446,
      38_593_859,
      565_656,
      824_824_824,
      2_121_212_121
    ]

    for id <- invalid_ids do
      refute Puzzle.id2_valid?(Integer.to_string(id))
      assert Puzzle.id2_valid?(Integer.to_string(id + 1))
    end
  end

  @tag pending: true
  test "focused example" do
  end
end
