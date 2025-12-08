defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&line_to_number/1) |> Enum.sum()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def line_to_number(line) do
    digits = Regex.scan(~r/\d/, line) |> List.flatten()
    first = hd(digits)
    last = List.last(digits)
    String.to_integer(first <> last)
  end
end
