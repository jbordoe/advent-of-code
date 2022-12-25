defmodule Aoc22.Day25.Test do
  use ExUnit.Case
  doctest Aoc22.Day25
  alias Aoc22.Day25

  @fixture "test/fixtures/2022/day_25.txt"

  test "#solution1 gets the right answer" do
    assert "2=-1=0" == Day25.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert nil == Day25.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
