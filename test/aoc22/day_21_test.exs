defmodule Aoc22.Day21.Test do
  use ExUnit.Case
  doctest Aoc22.Day21
  alias Aoc22.Day21

  @fixture "test/fixtures/2022/day_21.txt"

  test "#solution1 gets the right answer" do
    assert 152 == Day21.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 301 == Day21.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
