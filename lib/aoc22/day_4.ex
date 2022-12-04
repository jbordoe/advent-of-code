defmodule Aoc22.Day4 do
  use Helper

  @moduledoc """
  Solution for Day Four of Advent of Code
  https://adventofcode.com/2022/day/4
  """

  @default_filepath "priv/input/day_4.txt"

  def solve do
    [solution1(), solution2()]
  end

  def solution1(filepath \\ @default_filepath) do
    filepath
    |> prepare()
    |> Stream.filter(&covered?/1)
    |> Enum.count()
  end

  def solution2(filepath \\ @default_filepath) do
    filepath
    |> prepare()
    |> Stream.filter(&overlap?/1)
    |> Enum.count()
  end

  defp prepare(filepath) do
    filepath
    |> stream_lines_from_file()
    |> Stream.map(&format/1)
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
