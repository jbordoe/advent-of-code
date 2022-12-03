defmodule Aoc22.Day3 do
  @moduledoc """
  Solution for Day Three of Advent of Code
  https://adventofcode.com/2022/day/3
  """

  @default_filepath "priv/input/day_3.txt"

  @priorities 1..26
  |> Enum.map(fn i -> [{<<i+64>>, i+26}, {<<i+96>>, i}] end)
  |> List.flatten()
  |> Map.new()

  def solve do
    [solution1(), solution2()]
  end

  def solution1(filepath \\ @default_filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&(String.trim_trailing(&1, "\n")))
    |> Stream.map(fn s ->
      s
      |> String.split_at(Integer.floor_div(String.length(s), 2))
      |> compare()
    end)
    |> Enum.sum()
  end

  def solution2(filepath \\ @default_filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&(String.trim_trailing(&1, "\n")))
    |> Stream.chunk_every(3)
    |> Stream.map(&badge/1)
    |> Enum.map(&(Map.get(@priorities, &1)))
    |> Enum.sum()
  end

  defp compare({bag1, bag2}) do
    m1 = MapSet.new(String.graphemes(bag1))
    m2 = MapSet.new(String.graphemes(bag2))

    MapSet.intersection(m1,m2)
    |> MapSet.to_list
    |> Enum.map(&(Map.get(@priorities, &1)))
    |> List.first()
  end

  defp badge(bags) do
    bags
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list
    |> List.first()
  end
end
