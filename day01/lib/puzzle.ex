defmodule Puzzle do
  def part1(_lines) do
    # lines |> Enum.map(&line_to_number/1) |> Enum.sum()
    0
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def run(state, inputs), do: Enum.reduce(inputs, state, &transform/2)

  def parse_line("R" <> distance), do: {:right, String.to_integer(distance)}
  def parse_line("L" <> distance), do: {:left, String.to_integer(distance)}

  def transform(state, {:right, distance}) do
    transform_priv(state, distance)
  end

  def transform(state, {:left, distance}) do
    transform_priv(state, 0 - distance)
  end

  defp transform_priv({current, hits}, distance) do
    value = Integer.mod(current + distance, 100)
    {value, if(value == 0, do: hits + 1, else: hits)}
  end
end
