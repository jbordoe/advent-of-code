defmodule Aoc20.Day8.Test do
  use ExUnit.Case
  doctest Aoc20.Day8
  alias Aoc20.Day8

  @fixture "test/fixtures/2020/day_8.txt"

  test "#solution1 gets the right answer" do
    assert 5 == Day8.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 8 == Day8.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
