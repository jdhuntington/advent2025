defmodule Puzzle do
  def part1(lines) do
    lines |> load_ingredients() |> check_freshness()
  end

  def part2(_lines) do
    raise "Part 2 not implemented yet"
  end

  def load_ingredients(lines) do
    # for line <- lines do
    #   if(line == "")
    #   in_range_mode = false
    #   elsif(in_range_mode)
    #   range.append()
    # else
    #   ingredients.appent()
    # end

    ranges =
      for line <- lines, String.match?(line, ~r/-/) do
        [first, last] = String.split(line, "-") |> Enum.map(&String.to_integer/1)
        Range.new(first, last)
      end

    ingredients =
      for line <- lines, !(String.match?(line, ~r/-/) or line == "") do
        line |> String.to_integer()
      end

    %{ranges: ranges, ingredients: ingredients}
  end

  def check_freshness(%{ranges: ranges, ingredients: ingredients}) do
    Enum.count(ingredients, fn ingredient -> is_fresh?(ingredient, ranges) end)
  end

  def is_fresh?(ingredient, ranges) do
    Enum.any?(ranges, fn range -> ingredient in range end)
  end
end
