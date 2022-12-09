defmodule Aoc22.Day9 do
  use Helper

  @moduledoc """
  Solution for Day Nine of Advent of Code 2022
  https://adventofcode.com/2022/day/9
  """

  def solution1(input), do: simulate_rope(input, 2)

  def solution2(input), do: simulate_rope(input, 10)

  defp simulate_rope(input, knots) do
    input
    |> Stream.flat_map(&expand_line/1)
    |> Stream.transform(for(_ <- 1..knots, do: {0, 0}), &update/2)
    |> MapSet.new()
    |> MapSet.size()
  end

  # convert step of size n to n steps of size 1
  defp expand_line(<<dir::binary-size(1), " ", steps::binary>>) do
    n_steps = String.to_integer(steps)
    for _ <- 1..n_steps, do: step(dir)
  end

  # move rope head 1 step, update all child knots
  defp update({stepx, stepy}, [{hx, hy} | rest]) do
    knots = [{hx + stepx, hy + stepy} | rest] |> Enum.scan(&update/2)

    {[List.last(knots)], knots}
  end

  # move a knot based on parent knot position
  defp update({x, y} = t, h) do
    {dx, dy} = dist(h, t)

    [stepx, stepy] =
      if max(abs(dx), abs(dy)) > 1 do
        for d <- [dx, dy], do: if(d == 0, do: 0, else: d / abs(d))
      else
        [0, 0]
      end

    {x + stepx, y + stepy}
  end

  defp step("L"), do: {-1, 0}
  defp step("R"), do: {1, 0}
  defp step("U"), do: {0, 1}
  defp step("D"), do: {0, -1}

  defp dist({x1, y1}, {x2, y2}), do: {x1 - x2, y1 - y2}
end
