defmodule Aoc20.Day1.Test do
  use ExUnit.Case
  doctest Aoc20.Day1
  alias Aoc20.Day1

  @fixture "test/fixtures/2020/day_1.txt"

  test "#solution1 gets the right answer" do
    assert 514_579 == Day1.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 241_861_950 == Day1.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
