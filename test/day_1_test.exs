defmodule Aoc22.DayOne.Test do
  use ExUnit.Case
  doctest Aoc22.DayOne
  alias Aoc22.DayOne

  test "#solution1 gets the right answer" do
    assert 24000 == DayOne.solution1("test/fixtures/day_1.txt")
  end
  
  test "#solution2 gets the right answer" do
    assert 45000 == DayOne.solution2("test/fixtures/day_1.txt")
  end
end
