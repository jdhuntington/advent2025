defmodule Puzzle do
  def part1(lines) do
    lines |> parse_input() |> count_movable_rolls()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def count_movable_rolls(layout) do
    coordinated_layout = layout |> with_coordinates()

    coordinated_layout
    |> Enum.count(fn %{value: value, y: y, x: x} ->
      case value do
        :empty ->
          false

        :roll ->
          val = is_movable_for_coordinates(coordinated_layout, y, x)
          # IO.inspect([value, x, y, val])
          val
      end
    end)
  end

  def is_movable_for_coordinates(coordinated_layout, y, x) do
    for x_diff <- [-1, 0, 1], y_diff <- [-1, 0, 1], !(x_diff == 0 and y_diff == 0) do
      %{value: value} =
        Enum.find(coordinated_layout, %{value: :empty}, fn cell ->
          cell[:x] == x + x_diff and cell[:y] == y + y_diff
        end)

      # IO.inspect([x_diff, y_diff, diff_cell, diff_cell[:value]])
      # diff_cell[:value] == :roll
      value == :roll
    end
    |> Enum.count(fn x -> x end) < 4
  end

  ## .at(-1) wraps to end!
  def is_movable(layout, y, x) do
    Enum.sum_by([-1, 0, 1], fn y_diff ->
      Enum.count([-1, 0, 1], fn x_diff ->
        layout |> Enum.at(y + y_diff, []) |> Enum.at(x + x_diff, :empty) == :roll
      end)
    end) <= 4

    ## count includes one we are looking at, so <= handles that
  end

  def parse_input(input) do
    input |> Enum.map(&parse_input_line/1)
  end

  def with_coordinates(layout) do
    ## for version
    for {row, y} <- Enum.with_index(layout),
        {value, x} <- Enum.with_index(row) do
      %{value: value, y: y, x: x}
    end
  end

  def parse_input_line(line) do
    String.graphemes(line)
    |> Enum.map(
      &case &1 do
        "." -> :empty
        "@" -> :roll
      end
    )
  end
end
