defmodule Aoc22.Day16 do
  @moduledoc """
  Solutions for Day Sixteen of Advent of Code 2022
  https://adventofcode.com/2022/day/16
  """

  def solution1(input) do
    %{edges: edges, valves: valves} =
      input 
      |> Enum.map(&parse_line/1)
      |> Enum.reduce(%{edges: %{}, valves: []}, fn %{edges: e, valve: v}, acc ->
        acc
        |> Map.update(:edges, %{}, &Map.merge(&1, e))
        |> Map.update(:valves, [], &([v|&1]))
      end)
      |> IO.inspect

    dists =
      Enum.reduce(
        valves,
        %{},
        fn v, acc -> Map.put(acc, v, dists(v, edges)) end)
        |> IO.inspect
    
    edges =
      Enum.reduce(dists, edges, fn {{_id, rate}, dists}, e ->
        Map.merge(e, dists, fn _k, v1, v2 -> v1 + max(0, rate - v2) end)
      end)
      |> IO.inspect

    traverse({"AA", 0}, edges, Map.new(valves), dists)
    |> IO.inspect
  end

  def solution2(input) do
    input
  end

  defp traverse(pos, edges, valves, dists),
    do: traverse(pos, edges, valves, [], 30, dists)

  defp traverse(_, _, _, acc, t, _) when t <= 0, do: acc

  defp traverse({valve_id, 0}, edges, valves, acc, t, dists) do
    {{^valve_id, next_id}, _w} =
      edges
      |> Enum.filter(fn {{from, _to}, w} -> from == valve_id end)
      |> Enum.max_by(fn {{_from, _to}, w} -> w end)

    next = Enum.find(valves, fn {v, _r} -> v == next_id end)

    acc = [{:move, next_id}|acc]
    traverse(next, edges, valves, acc, t-1, dists)
  end

  defp traverse(valve, edges, valves, acc, t, dists) do
    release(valve, edges, valves, acc, t-1, dists)
  end

  defp release(_, _, _, acc, 0, _), do: acc

  defp release({valve_id, rate} = valve, edges, valves, acc, t, dists) do
    valves = Map.put(valves, valve_id, 0)

   IO.inspect({valve_id, rate, edges}) 
    edges = Map.merge(
      edges,
      Map.get(dists, valve),
      fn _k, v1, v2 -> v1 - max(0, rate-v2) end
    )
   IO.inspect(edges) 

    acc = [{valve_id, rate, t}|acc]
    traverse({valve_id, 0}, edges, valves, acc, t-1, dists)
  end

  defp dists({vertex_id, _}, edges), do: dists(edges, [vertex_id], 1, MapSet.new())

  defp dists(edges, [], _, _), do: edges

  defp dists(edges, vertices, val, visited) do
    current_edges = Enum.filter(
      Map.keys(edges),
      fn {from, to} = edge -> from in vertices and edge not in visited end
    ) 
    edges = Enum.reduce(
      current_edges,
      edges,
      fn edge, acc -> Map.put(acc, edge, val) end
    )
    next = Enum.map(current_edges, fn {_from, to} -> to end)
    dists(edges, next, val+1, MapSet.union(visited, MapSet.new(current_edges)))
  end

  defp parse_line("Valve " <> <<valve_id::binary-size(2)>> <> " has flow rate=" <> rest) do
    valve_id
    [rate, rest] = String.split(rest, ";")
    rate = String.to_integer(rate)

    edges = 
      String.split(rest, " ", parts: 5, trim: true)
      |> List.last()
      |> String.split(", ")
      # |> Enum.map(& [valve_id, &1] |> Enum.sort() |> List.to_tuple())
      # |> Enum.map(& {&1, 0})
      |> Enum.map(& {{valve_id, &1}, 0})
      |> Map.new()

    valve = {valve_id, rate}

    %{edges: edges, valve: valve}
  end
end
