defmodule Aoc22.Day7.Test do
  use ExUnit.Case
  doctest Aoc22.Day7
  alias Aoc22.Day7
  use Helper

  test "#solution1 gets the right answer" do
    assert 95437 == Day7.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 24_933_642 == Day7.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file("test/fixtures/day_7.txt")
end
