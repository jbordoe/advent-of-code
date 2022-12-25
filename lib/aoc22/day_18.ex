defmodule Aoc22.Day18 do
  @moduledoc """
  Solutions for Day Eighteen of Advent of Code 2022
  https://adventofcode.com/2022/day/18
  """

  def solution1(input) do
    input
    |> parse()
    |> surface_area()
    |> Nx.sum()
    |> Nx.to_number()
  end

  def solution2(input) do
    cubes = Nx.pad(parse(input), 0, [{2,2,0}, {2,2,0}, {2,2,0}])
    box = Nx.broadcast(1, cubes.shape)

    inner = Nx.floor(Nx.window_mean(box, {3,3,3}, padding: :same))
    outer = Nx.subtract(box, inner)
    filter = Nx.subtract(box, cubes)

    mold = flood(outer, filter)

    Nx.subtract(box, mold)
    |> surface_area()
    |> Nx.sum()
    |> Nx.to_number()
  end

  defp flood(prev, filter) do
    expanded =
      [{3,1,1},{1,3,1},{1,1,3}]
      |> Enum.map(fn window_shape ->
        Nx.add(Nx.window_sum(prev, window_shape, padding: :same), prev)
      end)
      |> Enum.reduce(&Nx.add/2)
      |> Nx.ceil
      |> Nx.min(filter)

    if expanded == prev, do: prev, else: flood(expanded, filter)
  end

  defp surface_area(cubes) do
    [{3,1,1},{1,3,1},{1,1,3}]
    |> Enum.map(fn window_shape ->
      Nx.subtract(Nx.window_sum(cubes, window_shape, padding: :same), cubes)
    end)
    |> Enum.reduce(&Nx.add/2)
    |> Nx.map(&Nx.subtract(6, &1))
    |> Nx.multiply(cubes)
  end

  def parse(input) do
    coords =
      input
      |> Enum.map(fn line ->
        String.split(line, ",") |> Enum.map(&String.to_integer/1)
      end)
      |> Nx.tensor(names: [:x, :y])

    shape =
      coords
      |> Nx.reduce_max([axes: [:x]])
      |> Nx.add(1)
      |> Nx.to_flat_list()
      |> List.to_tuple()

    Nx.broadcast(0, shape, names: [:x, :y, :z])
    |> Nx.indexed_put(coords, Nx.broadcast(1, {Nx.size(coords[y: 0])}))
  end
end
