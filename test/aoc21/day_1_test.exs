defmodule Aoc21.Day1.Test do
  use ExUnit.Case
  doctest Aoc21.Day1
  alias Aoc21.Day1

  @fixture "test/fixtures/2021/day_1.txt"

  test "#solution1 gets the right answer" do
    assert 7 == Day1.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 5 == Day1.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end

