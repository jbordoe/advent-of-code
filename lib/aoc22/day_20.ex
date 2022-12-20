defmodule Aoc22.Day20 do
  @moduledoc """
  Solutions for Day Twenty of Advent of Code 2022
  https://adventofcode.com/2022/day/20
  """

  def solution1(input), do: mix(Enum.map(input, &String.to_integer/1))
  
  def solution2(input), do: mix(Enum.map(input, &String.to_integer/1), 10, 811589153)

  def mix(nums, runs \\ 1, mul \\ 1) do
    nums = Enum.with_index(Enum.map(nums, &(&1 * mul)))

    nums
    |> Stream.cycle()
    |> Enum.take(length(nums) * runs)
    |> Enum.reduce(nums, &move_element/2)
    |> Enum.map(&elem(&1, 0))
    |> Stream.cycle()
    |> Stream.drop_while(&(&1 != 0))
    |> Stream.take_every(1000)
    |> Enum.slice(1,3)
    |> Enum.sum()
  end

  defp move_element({num, _original_idx} = el, list) do
    idx = Enum.find_index(list, &(&1 == el))
    {_, list} = List.pop_at(list, idx)
    new_idx = mod(idx + num, length(list))
    
    List.insert_at(list, new_idx, el)
  end

  # unsigned modulus
  defp mod(a, b) when a < 0, do: b + rem(a,b)
  defp mod(a, b), do: rem(a, b)
end
