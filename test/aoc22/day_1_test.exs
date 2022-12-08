defmodule Aoc22.Day1.Test do
  use ExUnit.Case
  doctest Aoc22.Day1
  alias Aoc22.Day1

  test "#solution1 gets the right answer" do
    assert 24000 == Day1.solution1("test/fixtures/day_1.txt")
  end

  test "#solution2 gets the right answer" do
    assert 45000 == Day1.solution2("test/fixtures/day_1.txt")
  end
end
