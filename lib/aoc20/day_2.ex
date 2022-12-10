defmodule Aoc20.Day2 do
  @moduledoc """
  Solution for Day Two of Advent of Code
  https://adventofcode.com/2020/day/2
  """

  def solution1(input) do
    input
    |> Stream.filter(&valid?/1)
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> Stream.filter(&valid2?/1)
    |> Enum.count()
  end

  defp valid?(line) do
    [min, max, chr, password] = parse(line)
    valid?(min, max, chr, password)
  end

  defp valid?(min, _max, _chr, ""), do: min <= 0
  defp valid?(_, 0, chr, <<chr::binary-size(1), _rest::binary>>), do: false

  defp valid?(min, max, chr, <<chr::binary-size(1), rest::binary>>),
    do: valid?(min - 1, max - 1, chr, rest)

  defp valid?(min, max, chr, <<_h::binary-size(1), rest::binary>>),
    do: valid?(min, max, chr, rest)

  defp valid2?(line) do
    [pos1, pos2, chr, password] = parse(line)
    str = [pos1, pos2] |> Enum.map(&String.at(password, &1 - 1)) |> Enum.join()
    valid?(1, 1, chr, str)
  end

  defp parse(line) do
    [min, max, chr, password] = String.split(line, ~r/[^a-z0-9]+/)
    [String.to_integer(min), String.to_integer(max), chr, password]
  end
end
