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
    cubes = parse(input)
    area = surface_area(cubes)
    interior_faces = 
      [{3,1,1},{1,3,1},{1,1,3}]
      |> Enum.map(fn window_shape ->
        Nx.window_sum(cubes, window_shape, padding: :same)
      end)
      |> Enum.reduce(&Nx.add/2)
      |> Nx.multiply(Nx.equal(0, cubes))
      |> Nx.equal(6)
      |> Nx.sum()
      |> Nx.multiply(6)

    area
    |> Nx.sum()
    |> Nx.subtract(interior_faces)
    |> Nx.to_number()
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
      |> IO.inspect

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
