defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&line_joltage/1) |> Enum.sum()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def line_joltage(bank) do
    {dig_one, pos_one} = highest_digit_and_pos(String.slice(bank, 0..(String.length(bank) - 2)))
    {dig_two, _} = highest_digit_and_pos(String.slice(bank, (pos_one + 1)..String.length(bank)))
    String.to_integer(dig_one <> dig_two)
  end

  def highest_digit_and_pos(bank) do
    # IO.inspect(bank)

    String.graphemes(bank)
    |> Enum.with_index()
    |> Enum.max_by(fn {val, _index} ->
      val
    end)
  end
end
