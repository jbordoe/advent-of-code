defmodule Aoc22.Day1.Test do
  use ExUnit.Case
  doctest Aoc22.Day1
  alias Aoc22.Day1

  @fixture "test/fixtures/2022/day_1.txt"

  test "#solution1 gets the right answer" do
    assert 24000 == Day1.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 45000 == Day1.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
