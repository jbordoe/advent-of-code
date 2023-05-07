require "test_helper"

require_relative "../../lib/aoc/2021/day_2"

class TestAoc2021Day2 < Minitest::Test
  def test_solution1
    assert_equal 150, Aoc2021::Day2.solution1(input)
  end

  def test_solution2
    assert_equal 900, Aoc2021::Day2.solution2(input)
  end
  
  def input
    File.readlines("../priv/test_fixtures/2021/day_2.txt", chomp: true)
  end
end
