defmodule Aoc20.Day10.Test do
  use ExUnit.Case
  doctest Aoc20.Day10
  alias Aoc20.Day10

  @fixture_1 "test/fixtures/2020/day_10/small.txt"
  @fixture_2 "test/fixtures/2020/day_10/large.txt"

  test "#solution1 gets the right answer" do
    assert 35 == Day10.solution1(input(@fixture_1))
    assert 220 == Day10.solution1(input(@fixture_2))
  end

  test "#solution2 gets the right answer" do
    assert 8 == Day10.solution2(input(@fixture_1))
    assert 19208 == Day10.solution2(input(@fixture_2))
  end
  
  defp input(fp), do: Helper.stream_lines_from_file(fp)
end
