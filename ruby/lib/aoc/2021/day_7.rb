require "test_helper"

require_relative "../../lib/aoc/2021/day_7"

class TestAoc2021Day7 < Minitest::Test
  def test_solution1
    assert_equal 150, Aoc2021::Day7.solution1(input)
  end

  def test_solution2
    assert_equal 900, Aoc2021::Day7.solution2(input)
  end
  
  def input
    File.readlines("../priv/test_fixtures/2021/day_7.txt", chomp: true)
  end
end

