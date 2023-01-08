defmodule Aoc22.Day10 do
  use Helper

  @moduledoc """
  Solution for Day Ten of Advent of Code 2022
  https://adventofcode.com/2022/day/10
  """

  def solution1(input) do
    input
    |> Stream.flat_map(&expand_instruction/1)
    |> Stream.scan(1, &(&1 + &2))
    |> Stream.with_index()
    |> Stream.map(fn {x, i} -> x * (i + 2) end)
    |> Stream.drop(18)
    |> Stream.take_every(40)
    |> Stream.take(6)
    |> Enum.sum()
  end

  def solution2(input) do
    sprite =
      input
      |> Stream.flat_map(&expand_instruction/1)
      |> Stream.scan(1, &(&1 + &2))
      |> Stream.drop(-1)

    crt = Stream.cycle(0..39)

    # append initial x position
    [1]
    |> Stream.concat(sprite)
    |> Stream.zip_with(crt, &render/2)
    |> Stream.chunk_every(40)
    |> Stream.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  # convert each add instruction to a noop followed by an add, to reflect 2 cycles
  defp expand_instruction(<<"addx ", incr::binary>>), do: [0, String.to_integer(incr)]
  defp expand_instruction(_), do: [0]

  defp render(x, crt) when abs(x - crt) <= 1, do: "#"
  defp render(_x, _crt), do: "."
end
