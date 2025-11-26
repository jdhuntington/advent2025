defmodule Day012024Test do
  use ExUnit.Case
  doctest Day012024

  test "greets the world" do
    assert Day012024.hello() == :world
  end

  test "can read the input" do
    IO.inspect("")

    {left, right} =
      "test/fixtures/input01.txt"
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

    diffs =
      Enum.zip(left, right)
      |> Enum.map(fn {l, r} -> abs(l - r) end)

    IO.inspect(diffs, label: "diffs")
    assert diffs == [2, 1, 0, 1, 2, 5]
    assert Enum.sum(diffs) == 11
  end

  # test "loads lists"

  # test "calculates differences"
end
