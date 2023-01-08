defmodule Aoc22.Day8.Test do
  use ExUnit.Case
  doctest Aoc22.Day8
  alias Aoc22.Day8
  use Helper

  @fixture "test/fixtures/2022/day_8.txt"

  test "#solution1 gets the right answer" do
    assert 21 == Day8.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 8 == Day8.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
