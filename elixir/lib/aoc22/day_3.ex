defmodule Aoc22.Day3 do
  @moduledoc """
  Solution for Day Three of Advent of Code
  https://adventofcode.com/2022/day/3
  """

  @priorities 1..26
              |> Enum.map(fn i -> [{<<i + 64>>, i + 26}, {<<i + 96>>, i}] end)
              |> List.flatten()
              |> Map.new()

  def solution1(input) do
    input
    |> Stream.map(fn s ->
      s
      |> String.split_at(Integer.floor_div(String.length(s), 2))
      |> Tuple.to_list()
      |> compare()
    end)
    |> Enum.sum()
  end

  def solution2(input) do
    input
    |> Stream.chunk_every(3)
    |> Stream.map(&compare/1)
    |> Enum.sum()
  end

  defp compare(bags) do
    bags
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
    |> Enum.map(&Map.get(@priorities, &1))
    |> List.first()
  end
end
