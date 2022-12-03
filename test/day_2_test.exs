defmodule Aoc22.Day2.Test do
  use ExUnit.Case
  doctest Aoc22.Day2
  alias Aoc22.Day2

  test "#solution1 gets the right answer" do
    assert 15 == Day2.solution1("test/fixtures/day_2.txt")
  end

  test "#solution2 gets the right answer" do
    assert 12 == Day2.solution2("test/fixtures/day_2.txt")
  end
end

