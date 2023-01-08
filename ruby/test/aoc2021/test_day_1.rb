require "test_helper"

require_relative "../../lib/aoc/2021/day_1"

class TestAoc < Minitest::Test
  def test_solution1
    assert 7 == Aoc2021::Day1.solution1(input)
  end

  def test_solution2
    assert 5 == Aoc2021::Day1.solution2(input)
  end
  
  def input
    File.readlines("../priv/test_fixtures/2021/day_1.txt", chomp: true)
  end
end
