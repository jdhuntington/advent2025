defmodule Day012024 do
  @moduledoc """
  Documentation for `Day012024`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day012024.process_file("test/fixtures/input01.txt")
  """

  def process_file(filepath) do
    {left, right} =
      filepath
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [a, b] = String.split(line, " ", trim: true)
        {String.to_integer(a), String.to_integer(b)}
      end)
      |> Enum.unzip()
      |> then(fn {l, r} -> {Enum.sort(l), Enum.sort(r)} end)

    IO.inspect(left, label: " left after loading and sorting")
    IO.inspect(right, label: "right after loading and sorting")

    differences = calculate_differences(left, right)
    %{left: left, right: right, differences: differences}
  end

  def calculate_differences(left, right) do
    Enum.zip(left, right)
    |> Enum.map(fn {l, r} -> abs(l - r) end)
  end
end
