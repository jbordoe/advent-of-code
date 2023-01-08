defmodule Aoc22.Day11.Test do
  use ExUnit.Case
  doctest Aoc22.Day11
  alias Aoc22.Day11

  @fixture "test/fixtures/2022/day_11.txt"

  test "#solution1 gets the right answer" do
    assert 10605 == Day11.solution1(input())
  end

  describe "#solution2 -" do
    test "one round", do: assert(24 == Day11.solution2(input(), 1))
    test "20 rounds", do: assert(10197 == Day11.solution2(input(), 20))
    test "1k rounds", do: assert(27_019_168 == Day11.solution2(input(), 1000))
    test "10k rounds", do: assert(2_713_310_158 == Day11.solution2(input(), 10_000))
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
