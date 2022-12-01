defmodule Aoc22.DayOne do
  @moduledoc """
  Solution for Day One of Advent of Code
  https://adventofcode.com/2022/day/1
  """

  def solution1(filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&(String.trim_trailing(&1, "\n")))
    |> Enum.reduce({0, 0}, fn
      "", {max, sum} -> {max(max, sum), 0}
      cal, {max, sum} -> {max, String.to_integer(cal) + sum}
    end)
    |> elem(0)
  end

  def solution2(filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&(String.trim_trailing(&1, "\n")))
    |> Enum.reduce([0], fn
      "", totals -> [0 | totals]
      cal, [current | rest] -> [String.to_integer(cal) + current | rest]
    end)
    |> Enum.sort(:desc)
    |> Enum.slice(0,3)
    |> Enum.sum()
  end
end
