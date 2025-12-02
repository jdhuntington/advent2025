defmodule Mix.Tasks.Solve do
  use Mix.Task

  @shortdoc "Run Advent of Code solutions"
  @moduledoc """
  Run Advent of Code solutions.

  Usage:
      mix solve part1 < priv/input.txt
      mix solve part2 < priv/input.txt
  """

  def run([part]) when part in ["part1", "part2"] do
    lines = read_stdin()

    result =
      case part do
        "part1" -> Puzzle.part1(lines)
        "part2" -> Puzzle.part2(lines)
      end

    IO.puts(result)
  end

  def run(_) do
    IO.puts(:stderr, "Usage: mix solve part1|part2 < input.txt")
    System.halt(1)
  end

  defp read_stdin do
    IO.stream(:stdio, :line)
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
  end
end
