defmodule Aoc20.Day5.Test do
  use ExUnit.Case
  doctest Aoc20.Day5
  alias Aoc20.Day5

  describe "#seat_id" do
    test "example 1" do
      assert 357 == Day5.seat_id("FBFBBFFRLR")
    end

    test "example 2" do
      assert 567 == Day5.seat_id("BFFFBBFRRR")
    end

    test "example 3" do
      assert 119 == Day5.seat_id("FFFBBBFRRR")
    end

    test "example 4" do
      assert 820 == Day5.seat_id("BBFFBBFRLL")
    end
  end
end
