defmodule Aoc20.Day3 do
  @moduledoc """
  Solution for Day Three of Advent of Code
  https://adventofcode.com/2020/day/3
  """

  def solution1(input) do
    input
    |> Stream.map(&String.graphemes/1)
    |> trees_passed(3, 1)
  end

  def solution2(input) do
    grid = Stream.map(input, &String.graphemes/1)

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn {right, down} -> trees_passed(grid, right, down) end)
    |> Enum.product()
  end

  defp trees_passed(grid, right, down) do
    grid
    |> Stream.take_every(down)
    |> Stream.drop(1)
    |> Stream.zip_with(
      Stream.iterate(right, &(&1 + right)),
      fn row, x -> Enum.at(row, rem(x, length(row))) end
    )
    |> Stream.filter(&(&1 == "#"))
    |> Enum.count()
  end
end
