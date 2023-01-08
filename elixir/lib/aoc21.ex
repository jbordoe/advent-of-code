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
      |> compare_windows(1)
    end

    def solution2(input) do
      input
      |> Enum.map(&String.to_integer/1)
      |> compare_windows(3)
    end

    defp compare_windows(nums, window_size) do
      nums
      |> Enum.zip(Enum.drop(nums, window_size))
      |> Enum.count(fn {prev, val} -> val > prev end)
    end
  end

  defmodule Day2 do
    def solution1(input) do
      {hpos, depth, _} = 
        input
        |> Stream.map(&parse_line/1)
        |> Enum.reduce({0,0,0}, &move/2)
      hpos * depth
    end

    def solution2(input) do
      {hpos,_aim,depth} = 
        input
        |> Stream.map(&parse_line/1)
        |> Enum.reduce({0,0,0}, &move/2)
      hpos * depth
    end

    defp move({"up", amt}, {x,y,z}), do: {x,y-amt,z}
    defp move({"down", amt}, {x,y,z}), do: {x,y+amt,z}
    defp move({"forward", amt}, {x,y,z}), do: {x+amt,y,z + (y*amt)}

    defp parse_line(line) do
      [direction, amt] = String.split(line)
      {direction, String.to_integer(amt)}
    end
  end
end
