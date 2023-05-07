require "test_helper"

require_relative "../../lib/aoc/2021/day_3"

class TestAoc2021Day3 < Minitest::Test
  def test_solution1
    assert_equal 198, Aoc2021::Day3.solution1(input)
  end

  def test_solution2
    assert_equal 230, Aoc2021::Day3.solution2(input)
  end
  
  def input
    File.readlines("../priv/test_fixtures/2021/day_3.txt", chomp: true)
  end
end

