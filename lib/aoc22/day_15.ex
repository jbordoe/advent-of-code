defmodule Aoc22.Day15 do
  @moduledoc """
  Solutions for Day Fifteen of Advent of Code 2022
  https://adventofcode.com/2022/day/15
  """
  defmodule Sensor do
    defstruct x: nil, y: nil, emptyset: MapSet.new([])
  end

  def solution1(input, y \\ 2_000_000) do
    {sensors, beacons} = parse(input)
    candidates_in_row(sensors, beacons, y)
  end

  def solution2(input) do
    {sensors, beacons} = parse(input)
    
    max_y = Enum.max(sensors, fn {_x,y} -> y end)
    min_y = Enum.min(sensors, fn {_x,y} -> y end)

    candidates_in_row(sensors, beacons, 0)
  end

  defp candidates_in_row(sensors, beacons, y) do
    covered_in_row =
      sensors
      |> Enum.map(&get_row(&1, y))
      |> Enum.sort()
      |> Enum.reduce([], fn
        [], acc -> acc
        range, [] -> [range]
        [x1, x2], [[i1, i2]|acc] ->
          cond do
            x2 <= i2 -> [[i1, i2]|acc]
            x1 <= i2 -> [[i1, x2]|acc]
            true -> [[x1, x2],[i1, i2]|acc]
          end
          |> IO.inspect
      end)
      |> Enum.map(fn [x1, x2] -> (x2-x1)+1 end)
      |> Enum.sum()

    beacons_in_row =
      beacons
      |> MapSet.filter(fn {_i,j} -> j == y end)
      |> MapSet.size()

    covered_in_row - beacons_in_row
  end

  defp get_row({i,j,range}, y) do
    case max(0, range - abs(j - y)) do
      0 -> []
      w -> [i - w, i + w]
    end
  end

  defp parse(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(
      {[] ,MapSet.new()},
      fn {s, b}, {sacc, bacc} -> {[s|sacc], MapSet.put(bacc, b)} end
    )
  end

  defp parse_line(ln) do
    [sx, sy, bx, by] = 
      Regex.scan(~r/[xy]=(-?\d+)/, ln, capture: :all_but_first)
      |> List.flatten
      |> Enum.map(&String.to_integer/1)
    
    range = abs(sx-bx) + abs(sy-by)
    sensor = {sx, sy, range}
    beacon = {bx, by}

    {sensor, beacon}
  end
end
