defmodule Aoc22.Day4.Test do
  use ExUnit.Case
  doctest Aoc22.Day4
  alias Aoc22.Day4

  @fixture "test/fixtures/2022/day_4.txt"

  test "#solution1 gets the right answer" do
    assert 2 == Day4.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 4 == Day4.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
