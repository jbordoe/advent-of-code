module Aoc2021
  module Day1
    def Day1.solution1(input)
      compare(input, 1)
    end
    
    def Day1.solution2(input)
      compare(input, 3)
    end

    private

    def Day1.compare(input, window)
      values = input.map(&:to_i)
      values[window...].zip(values)
        .filter {|pair| pair[0] > pair[1]}
        .size
    end
  end
end
