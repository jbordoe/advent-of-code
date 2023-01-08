defmodule Aoc22.Day25 do
  @moduledoc """
  Solutions for Day Twenty-Five of Advent of Code 2022
  https://adventofcode.com/2022/day/25
  """

  def solution1(input) do
    input
    |> Enum.map(&snafu2dec/1)
    |> Enum.sum()
    |> dec2snafu()
  end

  def solution2(input) do
    input
  end

  def dec2snafu(n) do
    n
    |> Integer.to_string(5)
    |> String.reverse()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> dec2snafu("", 0)
  end

  def dec2snafu([], acc, 0), do: acc
  def dec2snafu([], acc, carry), do: "#{carry}" <> acc
  def dec2snafu([4 | rest], acc, 0), do: dec2snafu(rest, "-" <> acc, 1)
  def dec2snafu([3 | rest], acc, 0), do: dec2snafu(rest, "=" <> acc, 1)
  def dec2snafu([n | rest], acc, 0) when n >= 5,
    do: dec2snafu(rest, "0" <> acc, n-4)
  def dec2snafu([n | rest], acc, 0), do: dec2snafu(rest, "#{n}" <> acc, 0)
  def dec2snafu([h | rest], acc, carry), do: dec2snafu([h + carry | rest], acc, 0)

  def snafu2dec(str), do: snafu2dec(str, 0)

  def snafu2dec("", acc), do: acc
  def snafu2dec("-" <> rest, acc), do: snafu2dec(rest, acc * 5 - 1) 
  def snafu2dec("=" <> rest, acc), do: snafu2dec(rest, acc * 5 - 2) 
  def snafu2dec(<<n::binary-size(1)>> <> rest, acc),
    do: snafu2dec(rest, acc * 5 + String.to_integer(n)) 
end
