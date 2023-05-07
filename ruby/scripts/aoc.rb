require "optparse"
require "require_all"

require_relative "../lib/aoc/2021/day_1"
require_relative "../lib/aoc/2021/day_2"
require_relative "../lib/aoc/2021/day_3"

options = {}
opts_parser = OptionParser.new do |opts|
  opts.banner = <<~EOS
    Usage:
      ruby scripts/aoc.rb

    Example:
    $ ruby scripts/aoc.rb --year=21 --day=15
  EOS

  opts.on("-h", "--help", "Prints this help screen") do
    puts opts
    exit
  end
  opts.on("-y", "--year NUMBER", "2-digit year") { |v| options[:year] = v }
  opts.on("-d", "--day NUMBER", "Day") { |v| options[:day] = v }
end
opts_parser.parse!

year = options[:year]
day = options[:day]

mod = Object.const_get("Aoc20#{year}::Day#{day}")

input_file = "../priv/input/20#{year}/day_#{day}.txt"
input = File.readlines(input_file, chomp: true)

puts mod.solution1(input)
puts mod.solution2(input)
