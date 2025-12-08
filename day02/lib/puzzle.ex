defmodule Puzzle do
  require Integer

  def part1(lines) do
    split_ids(Enum.at(lines, 0))
    |> Enum.map(&create_ranges/1)
    |> Enum.map(&expand_ranges/1)
    |> Enum.flat_map(fn val -> val end)
    |> Enum.reject(&id1_valid?/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def part2(lines) do
    split_ids(Enum.at(lines, 0))
    |> Enum.map(&create_ranges/1)
    |> Enum.map(&expand_ranges/1)
    |> Enum.flat_map(fn val -> val end)
    |> Enum.reject(&id1_valid?/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def split_ids(lines) do
    String.split(lines, ",")
  end

  def create_ranges(string_range) do
    [min, max] = String.split(string_range, "-")
    String.to_integer(min)..String.to_integer(max)
  end

  def expand_ranges(range) do
    Enum.to_list(range)
    |> Enum.map(&Integer.to_string/1)
  end

  def id1_valid?(id) do
    len = String.length(id)

    case Integer.is_even(len) do
      true ->
        {a, b} = String.split_at(id, Integer.floor_div(len, 2))
        a != b

      false ->
        true
    end
  end

  def id2_valid?(id) do
    len = String.length(id)

    case Integer.is_even(len) do
      true ->
        {a, b} = String.split_at(id, Integer.floor_div(len, 2))
        a != b

      false ->
        true
    end
  end

  def line_to_number(line) do
    digits = Regex.scan(~r/\d/, line) |> List.flatten()
    first = hd(digits)
    last = List.last(digits)
    String.to_integer(first <> last)
  end
end
