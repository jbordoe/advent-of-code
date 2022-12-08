defmodule Aoc21 do
  @moduledoc """
  Solutions for Advent of Code 2021
  https://adventofcode.com/2021
  """
  use Helper

  defmodule Day1 do
    def solution1(input) do
      input
      |> Enum.map(&String.to_integer/1)
      |> incr()
    end

    def solution2(input) do
      nums = Enum.map(input, &String.to_integer/1)
      nums
      |> Enum.zip(Enum.drop(nums, 3))
      |> Enum.filter(fn {prev, val} -> val > prev end)
      |> Kernel.length()
    end

    defp incr([h|t]), do: incr(t, h, 0)
    defp incr([h|t], prev, tot) when h > prev, do: incr(t, h, tot+1)
    defp incr([h|t], _prev, tot), do: incr(t, h, tot)
    defp incr([], _, tot), do: tot
  end
end
