defmodule Aoc22.Day15.Test do
  use ExUnit.Case
  doctest Aoc22.Day15
  alias Aoc22.Day15

  @fixture "test/fixtures/2022/day_15.txt"

  test "#solution1 gets the right answer" do
    assert 26 == Day15.solution1(input(), 10)
  end

  test "#solution2 gets the right answer" do
    assert 56000011 == Day15.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
