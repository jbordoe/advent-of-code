defmodule Aoc22.Day13.Test do
  use ExUnit.Case
  doctest Aoc22.Day13
  alias Aoc22.Day13

  @fixture "test/fixtures/2022/day_13.txt"

  test "#solution1 gets the right answer" do
    assert 13 == Day13.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert 140 == Day13.solution2(input())
  end

  describe "#parse -" do
    test "empty list" do
      assert [] == Day13.parse("[]")
    end
    test "simple list" do
      assert [1,20,300,40] == Day13.parse("[1,20,300,40]")
    end
    test "nested lists" do
      assert [[1],[[2]],[3,[4,[5],6]],7,8,[9]] ==
        Day13.parse("[[1],[[2]],[3,[4,[5],6]],7,8,[9]]")
    end
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
