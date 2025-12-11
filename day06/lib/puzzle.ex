defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&split_line/1) |> process_problems(&part1_extractor/2) |> Enum.sum()
  end

  def part2(lines) do
    lines |> Enum.map(&split_line/1) |> process_problems(&part2_extractor/2) |> Enum.sum()
  end

  def split_line(line) do
    line |> String.split(" ", trim: true)
  end

  def process_problems(lines, operand_extractor) do
    [operators | num_lines] = Enum.reverse(lines)

    operators
    |> Enum.with_index()
    |> Enum.map(fn {operator, index} ->
      operands = operand_extractor.(num_lines, index)

      case operator do
        "+" -> Enum.sum(operands)
        "*" -> Enum.product(operands)
      end
    end)
  end

  defp part1_extractor(num_lines, index) do
    num_lines |> Enum.map(fn nums -> Enum.at(nums, index) |> String.to_integer() end)
  end

  defp part2_extractor(_num_lines, _index) do
    [1]
  end
end
