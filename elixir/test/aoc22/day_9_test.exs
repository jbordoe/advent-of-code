defmodule Aoc22.Day9.Test do
  use ExUnit.Case
  doctest Aoc22.Day9
  alias Aoc22.Day9

  @fixture_s "test/fixtures/2022/day_9/small.txt"
  @fixture_l "test/fixtures/2022/day_9/large.txt"

  test "#solution1 gets the right answer" do
    input = Helper.stream_lines_from_file(@fixture_s)
    assert 13 == Day9.solution1(input)
  end

  test "#solution2 gets the right answer" do
    input = Helper.stream_lines_from_file(@fixture_s)
    assert 1 == Day9.solution2(input)
  end

  test "#solution2 gets the right answer (larger input)" do
    input = Helper.stream_lines_from_file(@fixture_l)
    assert 36 == Day9.solution2(input)
  end
end
