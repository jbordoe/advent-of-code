module Aoc2021
  module Day3
    def Day3.solution1(input)
      input.map(&:chars)
        .transpose
        .map do |bits|
          bits.group_by(&:itself)
            .transform_values(&:count)
            .sort_by(&:last)
            .map(&:first)
        end
          .transpose
          .map {|bits| bits.join.to_i(2)}
          .inject(&:*)
    end
    
    def Day3.solution2(input)
      nil
    end
  end
end


