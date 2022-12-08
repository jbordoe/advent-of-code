defmodule Aoc22.Day4 do
  use Helper

  @moduledoc """
  Solution for Day Four of Advent of Code
  https://adventofcode.com/2022/day/4
  """

  def solution1(input) do
    input
    |> Stream.map(&format/1)
    |> Stream.filter(&covered?/1)
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> Stream.map(&format/1)
    |> Stream.filter(&overlap?/1)
    |> Enum.count()
  end

  defp format(pair_str) do
    pair_str
    |> String.split(~r/[^\d]/)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
  end

  defp covered?([[min, _], [min, _]]), do: true
  defp covered?([[_, max], [_, max]]), do: true

  defp covered?(range_pair) do
    [[mina, maxa], [minb, maxb]] = Enum.sort(range_pair)
    mina <= minb && maxa >= maxb
  end

  defp overlap?([[mina, maxa], [minb, maxb]]) do
    max(mina, minb) <= min(maxa, maxb)
  end
end
