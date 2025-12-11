defmodule Puzzle do
  def part1(lines) do
    lines |> load_ingredients() |> check_freshness()
  end

  def part2(lines) do
    lines |> load_ingredients() |> unique_ingredients()
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

  def unique_ingredients(%{ranges: ranges, ingredients: _ingredients}) do
    ## naive, passes but slow
    ranges
    |> Enum.flat_map(fn range -> Range.to_list(range) end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def insert_range_into_ranges(insertable, ranges) do
    # find first overlapping range
    found = ranges |> Enum.find(fn range -> !Range.disjoint?(insertable, range) end)
    Range.new(Enum.min([insertable.first, found.first]), Enum.max([insertable.last, found.last]))
    # combine range with overlapping
    # ranges
  end

  def check_freshness(%{ranges: ranges, ingredients: ingredients}) do
    Enum.count(ingredients, fn ingredient -> is_fresh?(ingredient, ranges) end)
  end

  def is_fresh?(ingredient, ranges) do
    Enum.any?(ranges, fn range -> ingredient in range end)
  end
end
