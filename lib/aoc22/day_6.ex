defmodule Aoc22.Day6 do
  use Helper

  @moduledoc """
  Solution for Day Six of Advent of Code
  https://adventofcode.com/2022/day/6
  """

  @default_filepath "priv/input/day_6.txt"

  def solve(filepath \\ @default_filepath) do
    input = File.read!(filepath)

    [solution1(input), solution2(input)]
  end

  def solution1(input), do: find_marker(input, 4)

  def solution2(input), do: find_marker(input, 14)

  defp find_marker(input, len), do: find_marker([], String.graphemes(input), 0, len)

  defp find_marker(stack, _, n, len) when length(stack) == len, do: n

  defp find_marker(stack, [next | rest], n, len) do
    stack |> uniq_add(next) |> find_marker(rest, n + 1, len)
  end

  defp uniq_add(stack, chr), do: uniq_add(stack, [], chr)

  defp uniq_add([], acc, c), do: [c | Enum.reverse(acc)]
  defp uniq_add([c | _rest], acc, c), do: [c | Enum.reverse(acc)]
  defp uniq_add([h | rest], acc, c), do: uniq_add(rest, [h | acc], c)
end
