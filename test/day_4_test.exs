defmodule Aoc22.Day4.Test do
  use ExUnit.Case
  doctest Aoc22.Day4
  alias Aoc22.Day4

  test "#solution1 gets the right answer" do
    assert 2 == Day4.solution1("test/fixtures/day_4.txt")
  end

  test "#solution2 gets the right answer" do
    assert 4 == Day4.solution2("test/fixtures/day_4.txt")
  end
end
