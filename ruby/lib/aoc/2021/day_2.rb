module Aoc2021
  module Day2
    def Day2.solution1(input)
      dive(input)
        .fetch_values(:x, :aim)
        .inject(&:*)
    end
    
    def Day2.solution2(input)
      dive(input)
        .fetch_values(:x, :y)
        .inject(&:*)
    end

    private

    def Day2.dive(input)
      input.map do |line|
        dir, amt = line.split
        {dir: dir, amt: amt.to_i}
      end
        .reduce({x:0, y:0, aim: 0}) do |pos, move|
          case move[:dir]
          when "forward"
            pos[:x] += move[:amt]
            pos[:y] += move[:amt] * pos[:aim]
          when "down"
            pos[:aim] += move[:amt]
          when "up"
            pos[:aim] -= move[:amt]
          else
            raise "Unknown direction #{move[:dir]}"
          end
          pos
        end
    end
  end
end

