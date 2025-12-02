defmodule Puzzle do
  def part1(lines) do
    split_ids(Enum.at(lines, 0))
    |> IO.inspect()
    |> Enum.map(&create_ranges/1)
    |> IO.inspect()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def split_ids(lines) do
    String.split(lines, ",")
  end

  def create_ranges(string_range) do
    [min, max] = String.split(string_range, "-")
    String.to_integer(min)..String.to_integer(max)
  end

  def line_to_number(line) do
    digits = Regex.scan(~r/\d/, line) |> List.flatten()
    first = hd(digits)
    last = List.last(digits)
    String.to_integer(first <> last)
  end
end
