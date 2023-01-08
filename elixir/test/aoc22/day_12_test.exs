defmodule Aoc22.Day12.Test do
  use ExUnit.Case
  doctest Aoc22.Day12
  alias Aoc22.Day12

  @fixture "test/fixtures/2022/day_12.txt"

  test "#solution1 gets the right answer" do
    assert Day12.solution1(input()) == 31
  end

  test "#solution2 gets the right answer" do
    assert Day12.solution2(input()) == 29
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
