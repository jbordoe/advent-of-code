defmodule Aoc22.Day14.Test do
  use ExUnit.Case
  doctest Aoc22.Day14
  alias Aoc22.Day14

  @fixture "test/fixtures/2022/day_14.txt"

  test "#solution1 gets the right answer" do
    assert 24 == Day14.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 93 == Day14.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
