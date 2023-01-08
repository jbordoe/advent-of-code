defmodule Aoc20.Day6 do
  @moduledoc """
  Solution for Day Six of Advent of Code
  https://adventofcode.com/2020/day/6
  """

  def solution1(input) do
    input
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.map(&positives/1)
    |> Stream.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def solution2(input) do
    input
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.map(&agreed/1)
    |> Stream.map(&MapSet.size/1)
    |> Enum.sum()
  end

  defp positives(group), do: group |> Enum.map(&answers/1) |> Enum.reduce(&MapSet.union/2)
  defp agreed(group), do: group |> Enum.map(&answers/1) |> Enum.reduce(&MapSet.intersection/2)
  defp answers(person),
    do: person |> String.graphemes() |> Enum.reject(&(&1 == "")) |> MapSet.new()
end
