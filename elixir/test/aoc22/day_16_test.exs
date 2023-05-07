defmodule Aoc22.Day16.Test do
  use ExUnit.Case
  doctest Aoc22.Day16
  alias Aoc22.Day16

  @fixture "test/fixtures/2022/day_16.txt"

  test "#solution1 gets the right answer" do
    assert 1651 == Day16.solution1(input())
  end

  test "#solution2 gets the right answer" do
    #assert nil == Day16.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
