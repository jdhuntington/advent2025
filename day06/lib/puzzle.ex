defmodule Puzzle do
  def part1(lines) do
    lines |> Enum.map(&split_line/1) |> process_problems(&part1_extractor/2) |> Enum.sum()
  end

  def part2(lines) do
    lines
    |> parse_puzzle
    |> process_problems(&part2_extractor/2)
    |> Enum.sum()
  end

  def split_line(line) do
    line |> String.split(" ", trim: true)
  end

  def process_problems(lines, operand_extractor) do
    [operators | num_lines] = Enum.reverse(lines)

    operators
    |> Enum.with_index()
    |> Enum.map(fn {operator, index} ->
      operands = operand_extractor.(Enum.reverse(num_lines), index)

      case String.trim(operator) do
        "+" -> Enum.sum(operands)
        "*" -> Enum.product(operands)
      end
    end)
  end

  def part1_extractor(num_lines, index) do
    num_lines |> Enum.map(fn nums -> Enum.at(nums, index) |> String.to_integer() end)
  end

  def part2_extractor(num_lines, index) do
    num_lines
    |> Enum.map(fn line -> Enum.at(line, index) |> String.graphemes() end)
    |> Enum.zip()
    |> Enum.map(fn x ->
      Tuple.to_list(x) |> Enum.join("") |> String.trim() |> String.to_integer()
    end)
    |> Enum.reverse()
  end

  def parse_operand_line(line) do
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reject(fn {char, _index} -> char == " " end)
    |> Enum.map(fn {_char, index} -> index end)
  end

  def parse_puzzle(raw_lines) do
    line_length = raw_lines |> Enum.map(&String.length/1) |> Enum.max()

    lines =
      raw_lines
      |> Enum.reject(fn line -> line == "" end)
      |> Enum.map(fn line -> String.pad_trailing(line, line_length) end)

    operators = Enum.at(Enum.reverse(lines), 0)
    operator_positions = parse_operand_line(operators)
    offsets = operator_positions

    lines
    |> Enum.map(fn line ->
      offsets
      |> Enum.with_index()
      |> Enum.map(fn {start_offset, index} ->
        String.slice(
          line,
          start_offset,
          Enum.at(offsets, index + 1, line_length + 1) - start_offset - 1
        )
      end)
    end)
  end
end
