defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&parse_line/1) |> run({50, 0, 0}) |> elem(1)
  end

  def part2(lines) do
    lines |> Enum.map(&parse_line/1) |> run({50, 0, 0}) |> elem(2)
  end

  def run(inputs, state) do
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

  defp transform_priv({current, hits, passes}, distance) do
    value = Integer.mod(current + distance, 100)
    new_passes = pass_count(current, distance)

    case value do
      0 -> {value, hits + 1, passes + new_passes}
      _ -> {value, hits, passes + new_passes}
    end
  end

  def pass_count(current, distance) when distance > 0 do
    trunc((current + distance) / 100)
  end

  def pass_count(current, distance) when distance < 0 do
    pass_count(Integer.mod(100 - current, 100), -distance)
  end
end
