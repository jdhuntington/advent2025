defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&parse_line/1) |> ...(run |> get(the(hits)))
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def run(state, inputs) do
    Enum.reduce(inputs, state, &transform/2)
  end

  def parse_line("R" <> distance), do: {:right, String.to_integer(distance)}
  def parse_line("L" <> distance), do: {:left, String.to_integer(distance)}

  def transform({:right, distance}, state) do
    transform_priv(state, distance)
  end

  def transform({:left, distance}, state) do
    transform_priv(state, distance * -1)
  end

  defp transform_priv({current, hits}, distance) do
    value = Integer.mod(current + distance, 100)
    {value, if(value == 0, do: hits + 1, else: hits)}
  end
end
