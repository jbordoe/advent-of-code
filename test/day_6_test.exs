defmodule Aoc22.Day6.Test do
  use ExUnit.Case
  doctest Aoc22.Day6
  alias Aoc22.Day6

  test "#solution1 gets the right answers" do
    assert 7 == Day6.solution1("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
    assert 5 == Day6.solution1("bvwbjplbgvbhsrlpgdmjqwftvncz")
    assert 6 == Day6.solution1("nppdvjthqldpwncqszvftbrmjlhg")
    assert 10 == Day6.solution1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
    assert 11 == Day6.solution1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
  end

  test "#solution2 gets the right answers" do
    assert 19 == Day6.solution2("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
    assert 23 == Day6.solution2("bvwbjplbgvbhsrlpgdmjqwftvncz")
    assert 23 == Day6.solution2("nppdvjthqldpwncqszvftbrmjlhg")
    assert 29 == Day6.solution2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
    assert 26 == Day6.solution2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
  end
end
