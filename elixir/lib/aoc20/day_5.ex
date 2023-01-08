defmodule Aoc20.Day5 do
  @moduledoc """
  Solution for Day Five of Advent of Code
  https://adventofcode.com/2020/day/5
  """

  def solution1(input), do: input |> Enum.map(&seat_id/1) |> Enum.max()

  def solution2(input) do
    occupied = Enum.map(input, &seat_id/1)
    Enum.find(Enum.min(occupied)..Enum.max(occupied), &(&1 not in occupied))
  end

  def seat_id(str) do
    [row, col] = str |> String.split_at(7) |> Tuple.to_list() |> Enum.map(&to_integer/1)
    8 * row + col
  end

  defp to_integer(str), do: to_integer(str, 0)
  defp to_integer("", v), do: v

  defp to_integer(<<c::binary-size(1), rest::binary>>, v) when c in ~w[L F],
    do: to_integer(rest, v * 2)

  defp to_integer(<<c::binary-size(1), rest::binary>>, v) when c in ~w[R B],
    do: to_integer(rest, v * 2 + 1)
end
