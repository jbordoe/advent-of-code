defmodule Aoc22.DayOne.Test do
  use ExUnit.Case
  doctest Aoc22.DayOne
  alias Aoc22.DayOne

  test "gets the right answer" do
    assert 24000 == DayOne.solution("test/fixtures/day_1.txt")
  end
end
