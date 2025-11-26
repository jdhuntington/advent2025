defmodule Day012024Test do
  use ExUnit.Case
  # doctest Day012024

  test "can read the input" do
    IO.inspect("")

    result = Day012024.process_file("test/fixtures/input01.txt")

    IO.inspect(result.differences, label: "result.differences")
    assert result.differences == [2, 1, 0, 1, 2, 5]

    IO.inspect(Enum.sum(result.differences), label: "Enum.sum(result.differences)")
    assert Enum.sum(result.differences) == 11
  end

  test "process input02" do
    IO.puts("")
    result = Day012024.process_file("test/fixtures/input02.txt")

    # IO.inspect(result.differences, label: "result.differences")
    # assert result.differences == [2, 1, 0, 1, 2, 5]

    IO.inspect(Enum.sum(result.differences), label: "Enum.sum(result.differences)")
    # assert Enum.sum(result.differences) == 11
  end
end
