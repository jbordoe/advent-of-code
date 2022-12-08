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
