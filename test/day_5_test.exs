defmodule Aoc22.Day5.Test do
  use ExUnit.Case
  doctest Aoc22.Day5
  alias Aoc22.Day5

  test "#solution1 gets the right answer" do
    assert "CMZ" == Day5.solution1("test/fixtures/day_5.txt")
  end

  test "#solution2 gets the right answer" do
    assert "MCD" == Day5.solution2("test/fixtures/day_5.txt")
  end
end
