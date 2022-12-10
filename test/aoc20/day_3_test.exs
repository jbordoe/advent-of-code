defmodule Aoc20.Day3.Test do
  use ExUnit.Case
  doctest Aoc20.Day3
  alias Aoc20.Day3

  @fixture "test/fixtures/2020/day_3.txt"

  test "#solution1 gets the right answer" do
    assert 7 == Day3.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 336 == Day3.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
