defmodule Puzzle do
  def part1(lines) do
    [start | rest] = lines

    result =
      rest
      |> Enum.reduce(%{splits: 0, state: start}, fn line, %{splits: splits, state: state} ->
        %{splits: added_splits, state: next_state} = tick(state, line)
        %{splits: splits + added_splits, state: next_state}
      end)

    result[:splits]
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def tick(current, next_row) do
    # %{splits: 0, state: String.replace(current, "S", "|")}

    next_row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(%{splits: 0, state: ""}, fn
      char, acc ->
        calc_next_accumulated_value(char, acc, current, next_row)
    end)

    ##
    ## beam without splitter below
    ## beam with splitter below
  end

  def calc_next_accumulated_value(
        {char, index},
        %{splits: splits, state: state},
        current,
        next_row
      ) do
    case(char) do
      "." ->
        # 234
        # 1.5
        case {my_at(next_row, index - 1), my_at(current, index - 1), my_at(current, index),
              my_at(current, index + 1), my_at(next_row, index + 1)} do
          {"^", "|", _, _, _} -> %{splits: splits, state: state <> "|"}
          {_, _, _, "|", "^"} -> %{splits: splits, state: state <> "|"}
          {_, _, "|", _, _} -> %{splits: splits, state: state <> "|"}
          {_, _, "S", _, _} -> %{splits: splits, state: state <> "|"}
          {_, _, "^", _, _} -> %{splits: splits, state: state <> "."}
          {_, _, ".", _, _} -> %{splits: splits, state: state <> "."}
        end

      "^" ->
        case my_at(current, index) do
          "|" -> %{splits: splits + 1, state: state <> "^"}
          _ -> %{splits: splits, state: state <> "^"}
        end
    end
  end

  defp my_at(_string, offset) when offset < 0 do
    nil
  end

  defp my_at(string, offset) do
    String.at(string, offset)
  end
end
