defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&part1_line_joltage/1) |> Enum.sum()
  end

  def part2(lines) do
    lines |> Enum.map(&part2_line_joltage/1) |> Enum.sum()
  end

  def part1_line_joltage(bank) do
    {dig_one, pos_one} = highest_digit_and_pos(String.slice(bank, 0..(String.length(bank) - 2)))
    {dig_two, _} = highest_digit_and_pos(String.slice(bank, (pos_one + 1)..String.length(bank)))
    String.to_integer(dig_one <> dig_two)
  end

  def part2_line_joltage(bank) do
    # .... 12-1
    {val, _} =
      11..0
      |> Enum.reduce({"", 0}, fn current, {selected_digits, starting_position} ->
        {digit, new_start} =
          highest_digit_and_pos(
            String.slice(bank, starting_position..(String.length(bank) - current - 1))
          )

        # IO.inspect(digit)
        {selected_digits <> digit, starting_position + new_start + 1}
      end)

    # IO.inspect(val)
    String.to_integer(val)
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
