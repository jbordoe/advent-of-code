defmodule Aoc20.Day2.Test do
  use ExUnit.Case
  doctest Aoc20.Day2
  alias Aoc20.Day2

  @fixture "test/fixtures/2020/day_2.txt"

  test "#solution1 gets the right answer" do
    assert 2 == Day2.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 1 == Day2.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
