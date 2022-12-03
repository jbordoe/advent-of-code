defmodule Aoc22.Day2 do
  @moduledoc """
  Solution for Day Two of Advent of Code
  https://adventofcode.com/2022/day/2
  """

  @default_filepath "priv/input/day_2.txt"

  @shape_scores %{
    # Rock
    "A" => 1,
    # Paper
    "B" => 2,
    # Scissors
    "C" => 3
  }

  @xyz2abc %{
    "X" => "A",
    "Y" => "B",
    "Z" => "C"
  }

  def solve do
    [solution1(), solution2()]
  end

  def solution1(filepath \\ @default_filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(fn s ->
      [p1, p2] =
        s
        |> String.trim_trailing("\n")
        |> String.split()

      p2abc = Map.get(@xyz2abc, p2)
      score4round(p1 <> p2abc) + Map.get(@shape_scores, p2abc)
    end)
    |> Enum.sum()
  end

  def solution2(filepath \\ @default_filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(fn s ->
      {p1, p2} =
        s
        |> String.trim_trailing("\n")
        |> String.split()
        |> apply_strategy()

      score4round(p1 <> p2) + Map.get(@shape_scores, p2)
    end)
    |> Enum.sum()
  end

  defp score4round(p1p2) when p1p2 in ["AC", "BA", "CB"], do: 0
  defp score4round(p1p2) when p1p2 in ["AB", "BC", "CA"], do: 6
  defp score4round(_), do: 3

  defp apply_strategy(["A", "X"]), do: {"A", "C"}
  defp apply_strategy(["B", "X"]), do: {"B", "A"}
  defp apply_strategy(["C", "X"]), do: {"C", "B"}
  defp apply_strategy(["A", "Z"]), do: {"A", "B"}
  defp apply_strategy(["B", "Z"]), do: {"B", "C"}
  defp apply_strategy(["C", "Z"]), do: {"C", "A"}
  defp apply_strategy([p1, "Y"]), do: {p1, p1}
end
