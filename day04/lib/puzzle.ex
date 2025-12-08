defmodule Puzzle do
  def part1(lines) do
    lines |> parse_input() |> count_movable_rolls()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def count_movable_rolls(layout) do
    # def coordinates
    #   layout.each_y do |y|
    #     y.each_x do |x|
    #       yield [x,y]

    NEXT: clean up this method
    layout |> with_coordinates |> Enum.count()

    layout
    |> Enum.with_index()
    |> Enum.map(
      fn row ->
        {values, y} = row

        values
        |> Enum.with_index()
        |> Enum.map(fn {value, x} ->
          case value do
            :empty ->
              0

            :roll ->
              if(is_movable(layout, y, x)) do
                1
              else
                0
              end
          end
        end)
      end
      |> Enum.sum()
    )
    |> Enum.sum()
  end

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
