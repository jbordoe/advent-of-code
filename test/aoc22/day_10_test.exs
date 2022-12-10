defmodule Aoc22.Day10.Test do
  use ExUnit.Case
  doctest Aoc22.Day10
  alias Aoc22.Day10

  @fixture "test/fixtures/2022/day_10.txt"

  test "#solution1 gets the right answer" do
    input = Helper.stream_lines_from_file(@fixture)
    assert 13140 == Day10.solution1(input)
  end

  test "#solution2 gets the right answer" do
    input = Helper.stream_lines_from_file(@fixture)
    expected = """
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....\
"""
    assert expected == Day10.solution2(input)
  end
end

