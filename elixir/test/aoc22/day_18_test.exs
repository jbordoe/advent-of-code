defmodule Aoc22.Day18.Test do
  use ExUnit.Case
  doctest Aoc22.Day18
  alias Aoc22.Day18

  @fixture "test/fixtures/2022/day_18.txt"

  test "#solution1 gets the right answer" do
    assert 64 == Day18.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 58 == Day18.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
