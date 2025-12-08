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
    |> Enum.reject(&id2_valid?/1)
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

  ## single character
  def id2_valid?(<<_::utf8>>), do: true

  def id2_valid?(id) do
    # from 1 to len / 2
    # Enum.any
    #   divide into segments of length N
    #   if all are equal, return INVALID Enum.all?
    # IO.puts(id)
    segment_sizes = 1..Integer.floor_div(String.length(id), 2)

    !Enum.any?(segment_sizes, fn size ->
      all_segments_equal(id_to_segments_of_length(size, id))
    end)
  end

  def id_to_segments_of_length(size, id) do
    id
    |> String.graphemes()
    |> Enum.chunk_every(size)
    |> Enum.map(&Enum.join/1)
  end

  def all_segments_equal(segments) when length(segments) < 2, do: false

  def all_segments_equal(segments) do
    Enum.all?(segments, &(&1 == Enum.at(segments, 0)))
  end

  def line_to_number(line) do
    digits = Regex.scan(~r/\d/, line) |> List.flatten()
    first = hd(digits)
    last = List.last(digits)
    String.to_integer(first <> last)
  end
end
