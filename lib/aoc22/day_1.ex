defmodule Aoc22.Day1 do
  @moduledoc """
  Solution for Day One of Advent of Code
  https://adventofcode.com/2022/day/1
  """

  def solution1(input) do
    input
    |> Enum.reduce({0, 0}, fn
      "", {max, sum} -> {max(max, sum), 0}
      cal, {max, sum} -> {max, String.to_integer(cal) + sum}
    end)
    |> elem(0)
  end

  def solution2(input) do
    input
    |> Enum.reduce([0], fn
      "", totals -> [0 | totals]
      cal, [current | rest] -> [String.to_integer(cal) + current | rest]
    end)
    |> Enum.sort(:desc)
    |> Enum.slice(0, 3)
    |> Enum.sum()
  end
end
