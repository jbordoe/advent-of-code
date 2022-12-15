defmodule Aoc22.Day14 do
  @moduledoc """
  Solutions for Day Fourteen of Advent of Code 2022
  https://adventofcode.com/2022/day/14
  """
  defmodule Grid do
    defstruct floor: -1, filled: MapSet.new()

    def fill(%Grid{} = grid, el),
      do: Map.update(grid, :filled, nil, &MapSet.put(&1, el))

    def filled?(%Grid{floor: floor_y, filled: f}, {_x, y} = point),
      do: point in f || floor_y == y

    def below?(%Grid{filled: filled, floor: floor_y}, {x, y}) do
      filled
      |> Enum.filter(fn {i, j} -> i == x && j > y end)
      |> case do
        [_ | _] = points -> Enum.min(points)
        [] -> if floor_y > y, do: {x, floor_y}, else: nil
      end
    end

    def set_floor(%Grid{filled: filled} = g) do
      {_, max_y} = Enum.max_by(filled, fn {_x, y} -> y end)
      Map.put(g, :floor, max_y + 2)
    end

    def plot(%Grid{} = grid, {x, y}) do
      g = Grid.fill(grid, {x, y})
      min_x = Enum.min(g.filled) |> elem(0)
      max_x = Enum.max(g.filled) |> elem(0)

      max_y =
        case grid.floor do
          -1 -> Enum.max_by(g.filled, &elem(&1, 1)) |> elem(1)
          f -> f
        end

      min_y = 0

      for j <- min_y..max_y do
        for i <- min_x..max_x do
          if Grid.filled?(grid, {i, j}) do
            '#'
          else
            if {x, y} == {i, j}, do: '+', else: '.'
          end
        end
        |> Enum.join()
      end
      |> Enum.concat([""])
      |> Enum.join("\n")
      |> IO.puts()
    end
  end

  def solution1(input) do
    input
    |> Stream.flat_map(&parse/1)
    |> Enum.reduce(%Grid{}, &fill_line/2)
    |> add_sand()
  end

  def solution2(input) do
    input
    |> Stream.flat_map(&parse/1)
    |> Enum.reduce(%Grid{}, &fill_line/2)
    |> Grid.set_floor()
    |> add_sand()
  end

  defp add_sand(grid), do: add_sand({500, 0}, grid, 0)

  defp add_sand({x, y}, grid, n) do
    [{x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1}]
    |> Enum.map(fn xy -> Grid.filled?(grid, xy) end)
    |> case do
      [_, false, _] ->
        # look for highest filled point below current position
        case Grid.below?(grid, {x, y}) do
          nil -> n
          {^x, yb} -> add_sand({x, yb - 1}, grid, n)
        end

      [false, true, _] ->
        add_sand({x - 1, y + 1}, grid, n)

      [true, true, false] ->
        add_sand({x + 1, y + 1}, grid, n)

      [true, true, true] ->
        if {x, y} == {500, 0},
          do: n + 1,
          else: add_sand({500, 0}, Grid.fill(grid, {x, y}), n + 1)
    end
  end

  defp fill_line([[x, y1], [x, y2]], grid),
    do: Enum.reduce(y1..y2, grid, fn y, g -> Grid.fill(g, {x, y}) end)

  defp fill_line([[x1, y], [x2, y]], grid),
    do: Enum.reduce(x1..x2, grid, fn x, g -> Grid.fill(g, {x, y}) end)

  defp parse(ln) do
    ln
    |> String.split(~r/[^\d]+/)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.chunk_every(2, 1, :discard)
  end
end
