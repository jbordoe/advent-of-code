defmodule Aoc22.Day17.Test do
  use ExUnit.Case
  doctest Aoc22.Day17
  alias Aoc22.Day17

  @fixture "test/fixtures/2022/day_17.txt"

  test "#solution1 gets the right answer" do
    assert 3068 == Day17.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 1514285714288 == Day17.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
