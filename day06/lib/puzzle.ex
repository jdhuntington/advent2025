defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&split_line/1) |> process_problems() |> Enum.sum()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def split_line(line) do
    line |> String.split(" ", trim: true)
  end

  def process_problems(lines) do
    [operators | num_lines] = Enum.reverse(lines)

    operators
    |> Enum.with_index()
    |> Enum.map(fn {operator, index} ->
      operands = num_lines |> Enum.map(fn nums -> Enum.at(nums, index) |> String.to_integer() end)

      case operator do
        "+" -> Enum.sum(operands)
        "*" -> Enum.product(operands)
      end
    end)
  end
end
