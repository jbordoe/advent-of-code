defmodule Aoc20.Day6.Test do
  use ExUnit.Case
  doctest Aoc20.Day6
  alias Aoc20.Day6

  @fixture "test/fixtures/2020/day_6.txt"

  test "#solution1 gets the right answer" do
    assert 11 == Day6.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 6 == Day6.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
