defmodule Aoc20.Day1 do
  @moduledoc """
  Solution for Day One of Advent of Code
  https://adventofcode.com/2020/day/1
  """

  def solution1(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> find_sum(2020, 2)
    |> Enum.product()
  end

  def solution2(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> find_sum(2020, 3)
    |> Enum.product()
  end

  defp find_sum([], _h, _n), do: nil
  defp find_sum([h | _], h, 1), do: [h]
  defp find_sum([_h | t], sum, 1), do: find_sum(t, sum, 1)

  defp find_sum([h | t], sum, n) when h > sum, do: find_sum(t, sum, n)

  defp find_sum([h | t], sum, n) when n > 1 do
    case find_sum(t, sum - h, n - 1) do
      nil -> find_sum(t, sum, n)
      numbers -> [h | numbers]
    end
  end
end
