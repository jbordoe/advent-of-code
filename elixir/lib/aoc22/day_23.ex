defmodule Aoc22.Day23 do
  @moduledoc """
  Solutions for Day Twenty-Three of Advent of Code 2022
  https://adventofcode.com/2022/day/23
  """

  @directions [:north, :south, :west, :east]

  def solution1(input, rounds \\ 10) do
    elves = parse(input)

    end_positions =
     @directions 
     |> Stream.cycle()
     |> Stream.chunk_every(4, 1)
     |> Enum.take(rounds)
     |> Enum.reduce(elves, &move/2)

    {min_x, max_x} = Enum.min_max(Enum.map(end_positions, fn {x, _} -> x end))
    {min_y, max_y} = Enum.min_max(Enum.map(end_positions, fn {_, y} -> y end))

    ((max_x+1 - min_x) * (max_y+1 - min_y)) - length(elves)
  end

  def solution2(input) do
    elves = parse(input)
    
    @directions 
    |> Stream.cycle()
    |> Stream.chunk_every(4, 1)
    |> Enum.reduce_while({MapSet.new(elves), 1}, fn dirs, {prev, count} ->
      moved = MapSet.new(move(dirs, prev))
      if moved == prev, do: {:halt, count}, else: {:cont, {moved, count+1}}
    end)
  end

  defp move(dirs, elves) do
    elves
    |> Enum.group_by(fn {x,y} ->
      adj = Enum.map(dirs, fn d -> {d, window(elves, x, y, d)} end)
      if Enum.all?(adj, fn {_, count} -> count == 0 end) do
        {x, y}
      else
        {dir, _} = Enum.find(adj, {nil, nil}, fn {_, c} -> c == 0 end)
        update({x,y}, dir)
      end
    end)
    |> Enum.flat_map(fn
      {new_pos, old} when length(old) == 1 -> [new_pos]
      {_, old} -> old
    end)
    |> MapSet.new()
  end
  
  defp update({x, y}, :north), do: {x, y-1}
  defp update({x, y}, :east), do: {x+1, y}
  defp update({x, y}, :south), do: {x, y+1}
  defp update({x, y}, :west), do: {x-1, y}
  defp update({x, y}, _), do: {x, y}

  defp window(elves, x, y, :adj), do:
    Enum.sum(Enum.map([:north, :south, :east, :west], &window(elves, x, y, &1)))

  defp window(elves, x, y, :north), do: window(elves, [x-1,x,x+1], [y-1])
  defp window(elves, x, y, :east), do: window(elves, [x+1], [y-1, y, y+1])
  defp window(elves, x, y, :south), do: window(elves, [x-1,x,x+1], [y+1])
  defp window(elves, x, y, :west), do: window(elves, [x-1], [y-1, y, y+1])
  
  defp window(elves, xset, yset) do
    Enum.count(for(x <- xset, y <- yset, do: {x,y}), &(&1 in elves))
  end

  defp parse(input) do
    input
    |> Enum.with_index()
    |> Enum.flat_map(fn {ln, j} ->
      ln
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reject(fn {el, _} -> el == "." end)
      |> Enum.into(MapSet.new(), fn {_el, i} -> {i, j} end)
    end)
  end

  defp plot(elves) do
    {min_x, max_x} = Enum.min_max(Enum.map(elves, fn {x, _} -> x end))
    {min_y, max_y} = Enum.min_max(Enum.map(elves, fn {_, y} -> y end))

    for y <- min_y..max_y do
      Enum.map(min_x..max_x, &(if {&1, y} in elves, do: "#", else: "."))
      |> Enum.join()
    end
    |> Enum.concat(["\n"])
    |> Enum.join("\n")
    |> IO.puts

    elves
  end
end
