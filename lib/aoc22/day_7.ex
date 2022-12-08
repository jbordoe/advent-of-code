defmodule Aoc22.Day7 do
  use Helper

  @moduledoc """
  Solution for Day Seven of Advent of Code
  https://adventofcode.com/2022/day/7
  """

  @default_filepath "priv/input/day_7.txt"

  def solve(filepath \\ @default_filepath) do
    input = stream_lines_from_file(filepath)

    [solution1(input), solution2(input)]
  end

  def solution1(input) do
    input
    |> directory_sizes()
    |> Map.values()
    |> Enum.filter(&(&1 <= 100000))
    |> Enum.sum()
  end 

  def solution2(input) do
    totals = directory_sizes(input)

    %{["/"] => total_used} = totals
    to_clear = total_used - 40000000

    totals
    |> Map.values()
    |> Enum.filter(&(&1 >= to_clear))
    |> Enum.min()
  end

  defp directory_sizes(input) do 
    input
    |> Enum.reduce(%{totals: %{}, path: [], seen: MapSet.new(), ls: false}, &step/2)
    |> Map.get(:totals)
  end

  defp step(<<"$", _rest::binary>> = line, %{ls: true, seen: seen, path: p} = acc) do
    step(line, %{acc | ls: false, seen: MapSet.put(seen, p)})
  end
  defp step("$ cd /", acc), do: %{acc | path: ["/"]}
  defp step("$ cd ..", %{path: [_cwd|parent]} = acc), do: %{acc | path: parent}
  defp step(<<"$ cd ", dir::binary>>, %{path: p} = acc), do: %{acc | path: [dir|p]}

  defp step("$ ls", acc), do: %{acc | ls: true}
  defp step(<<"dir ", dir::binary>>, %{path: p, totals: t} = acc) do
    %{acc | totals: Map.update(t, [dir|p], 0, &(&1))}
  end

  defp step(line, %{path: path, totals: totals, seen: seen} = acc) do
    if path in seen do
      acc
    else
      size = line |> String.split() |> List.first() |> String.to_integer()
      totals = update_totals(totals, path, size)
      %{acc | totals: totals}
    end
  end

  defp update_totals(totals, [_|rest] = path, amt) do
    update_totals(Map.update(totals, path, amt, &(&1 + amt)), rest, amt)
  end
  defp update_totals(totals, _path, _amt), do: totals
end

