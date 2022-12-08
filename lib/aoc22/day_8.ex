defmodule Aoc22.Day8 do
  use Helper

  @moduledoc """
  Solution for Day Eight of Advent of Code
  https://adventofcode.com/2022/day/8
  """

  defmodule Tree do
    defstruct id: nil, height: nil
  end

  @default_filepath "priv/input/day_8.txt"

  def solve(filepath \\ @default_filepath) do
    [solution1(filepath), solution2(filepath)]
  end

  def solution1(filepath) do
    grid = grid_from_file(filepath)

    (grid ++ rotate(grid) ++ hflip(grid) ++ hflip(rotate(grid)))
    |> Enum.map(&visible/1)
    |> Enum.reduce(&MapSet.union/2)
    |> MapSet.size()
  end

  def solution2(filepath) do
    grid = grid_from_file(filepath)

    (grid ++ rotate(grid) ++ hflip(grid) ++ hflip(rotate(grid)))
    |> Enum.map(&vdists/1)
    |> Enum.reduce(fn m, agg ->
      Map.merge(m, agg, fn _k, v1, v2 -> v1 * v2 end)
    end)
    |> Map.values()
    |> Enum.max()
  end

  # find trees visible (from the left) in given row
  defp visible([%Tree{height: h} = tree | rest]), do: visible(rest, h, MapSet.new([tree]))
  defp visible([], _, acc), do: acc

  defp visible([%Tree{height: h} = tree | t], max, acc) when h > max do
    visible(t, h, MapSet.put(acc, tree))
  end

  defp visible([_ | rest], max, agg), do: visible(rest, max, agg)

  # calculate the (l to r) viewing distances for each tree in the given row
  defp vdists(trees), do: vdists(trees, %{})

  defp vdists([%Tree{height: height} = tree | rest], results) do
    vdist =
      rest
      |> Enum.reduce_while(0, fn %Tree{height: h}, acc ->
        if h < height, do: {:cont, acc + 1}, else: {:halt, acc + 1}
      end)

    vdists(rest, Map.put(results, tree, vdist))
  end

  defp vdists([], results), do: results

  defp grid_from_file(filepath) do
    filepath
    |> stream_lines_from_file()
    |> Enum.map(&String.graphemes/1)
    |> Enum.with_index()
    |> Enum.map(fn {row, i} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {el, j} ->
        %Tree{id: "#{i},#{j}", height: String.to_integer(el)}
      end)
    end)
  end
end
