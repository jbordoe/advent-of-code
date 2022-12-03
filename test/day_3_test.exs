defmodule Aoc22.Day3.Test do
  use ExUnit.Case
  doctest Aoc22.Day3
  alias Aoc22.Day3

  test "#solution1 gets the right answer" do
    assert 157 == Day3.solution1("test/fixtures/day_3.txt")
  end

  test "#solution2 gets the right answer" do
    assert 70 == Day3.solution2("test/fixtures/day_3.txt")
  end
end

