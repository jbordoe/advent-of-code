defmodule Aoc20.Day10 do
  @moduledoc """
  Solution for Day Ten of Advent of Code 2020
  https://adventofcode.com/2020/day/10
  """

  def solution1(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> diffs()
    |> Enum.frequencies()
    |> Map.take([1,3])
    |> Map.update(3, nil, &(&1 + 1))
    |> Map.values()
    |> Enum.product()
  end

  # find number of ordered sublists where values increase by no more than 3
  def solution2(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> diffs()
    |> Enum.reduce({0, 0}, fn el, {n, m} -> if el + m >= 3, do: {n+1, 0}, else: {n, el+m} end)
    |> elem(0)
  end

  def diffs(values) do
    values
    |> Enum.sort()
    |> List.insert_at(0,0)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x,y] -> y-x end)
  end
end
