defmodule Aoc21.Day2.Test do
  use ExUnit.Case
  doctest Aoc21.Day2
  alias Aoc21.Day2

  @fixture "test/fixtures/2021/day_2.txt"

  test "#solution1 gets the right answer" do
    assert 150 == Day2.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 900 == Day2.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end

