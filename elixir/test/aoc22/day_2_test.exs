defmodule Aoc22.Day2.Test do
  use ExUnit.Case
  doctest Aoc22.Day2
  alias Aoc22.Day2

  @fixture "test/fixtures/2022/day_2.txt"

  test "#solution1 gets the right answer" do
    assert 15 == Day2.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 12 == Day2.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
