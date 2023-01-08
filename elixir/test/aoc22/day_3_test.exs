defmodule Aoc22.Day3.Test do
  use ExUnit.Case
  doctest Aoc22.Day3
  alias Aoc22.Day3

  @fixture "test/fixtures/2022/day_3.txt"

  test "#solution1 gets the right answer" do
    assert 157 == Day3.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 70 == Day3.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
