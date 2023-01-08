defmodule Aoc22.Day5.Test do
  use ExUnit.Case
  doctest Aoc22.Day5
  alias Aoc22.Day5

  @fixture "test/fixtures/2022/day_5.txt"

  test "#solution1 gets the right answer" do
    assert "CMZ" == Day5.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert "MCD" == Day5.solution2(input())
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
