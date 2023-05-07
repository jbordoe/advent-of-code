defmodule Aoc22.Day23.Test do
  use ExUnit.Case
  doctest Aoc22.Day23
  alias Aoc22.Day23

  @fixture "test/fixtures/2022/day_23.txt"

  test "#solution1 gets the right answer" do
    assert 110 == Day23.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 20 == Day23.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
