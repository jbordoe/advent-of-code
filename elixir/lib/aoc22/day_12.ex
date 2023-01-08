defmodule Aoc22.Day12 do
  @moduledoc """
  Solutions for Day Twelve of Advent of Code 2022
  https://adventofcode.com/2022/day/12
  """

  defmodule AStar do
    @moduledoc """
    Implements the A* search algorithm
    """

    defmodule Node, do: defstruct([:value, :h, path: [], cost: 0])

    @doc """
    Use A* search to find the optimal path from one state to another.

    See: https://en.wikipedia.org/wiki/A*_search_algorithm
    for a description of the algorithm.

    ## Parameters

      - start: A value representing the initial state
      - goal: A value representing the desired state
      - nbfn: A function returning the neighbours of a given state
      - c: A function returning the cost of moving from one given state to another
      - h: A function returning an estimate of the cost from a given state to final state

    """
    def find_optimal_path(start, goal, nbfn, c, h) do
      start_node = to_node(start, h)
      goal_node = to_node(goal, h)
      closed = MapSet.new()
      open = %{start => start_node}

      astar(goal_node, nbfn, c, h, open, closed)
    end

    defp astar(_, _, _, _, open, _) when open == %{}, do: false

    defp astar(goal, nbfn, c, h, open, closed) do
      current = Enum.min_by(Map.values(open), fn %Node{h: h, cost: c} -> h + c end)

      if current.value == goal.value do
        current.path
        |> Enum.reverse()
        |> Enum.map(& &1.value)
      else
        open = Map.delete(open, current.value)

        open =
          current
          |> neighbours(nbfn, c, h)
          |> Enum.reject(&(&1.value in closed))
          |> Enum.reduce(open, fn %Node{value: v} = nb, acc ->
            updated =
              case Map.get(acc, v) do
                nil -> nb
                prev -> Enum.min_by([nb, prev], fn p -> p.cost + p.h end)
              end

            Map.put(acc, v, updated)
          end)

        astar(goal, nbfn, c, h, open, MapSet.put(closed, current.value))
      end
    end

    defp neighbours(nd, neighbourfn, costfn, hfn) do
      nd.value
      |> neighbourfn.()
      |> Enum.map(fn v ->
        %Node{
          value: v,
          h: hfn.(v),
          path: [nd | nd.path],
          cost: costfn.(nd.value, v) + nd.cost
        }
      end)
    end

    defp to_node(value, hfn), do: %Node{value: value, h: hfn.(value)}
  end

  def solution1(input) do
    grid = build_grid(input)
    {startx, starty, _} = Enum.find(Map.values(grid), fn {_, _, z} -> z == ?S end)
    {goalx, goaly, _} = Enum.find(Map.values(grid), fn {_, _, z} -> z == ?E end)

    start = {startx, starty, ?a}
    goal = {goalx, goaly, ?z}
    grid = %{grid | {goalx, goaly} => goal, {startx, starty} => start}

    AStar.find_optimal_path(
      start,
      goal,
      &adj(&1, grid),
      fn _, _ -> 1 end,
      &euclidean(&1, goal)
    )
    |> length()
  end

  def solution2(input) do
    grid = build_grid(input)
    {goalx, goaly, _} = Enum.find(Map.values(grid), fn {_, _, z} -> z == ?E end)
    goal = {goalx, goaly, ?z}
    grid = Map.put(grid, {goalx, goaly}, goal)

    grid
    |> Map.values()
    |> Enum.filter(fn {_, _, z} -> z == ?a end)
    |> Enum.map(fn start ->
      AStar.find_optimal_path(
        start,
        goal,
        &adj(&1, grid),
        fn _, _ -> 1 end,
        &euclidean(&1, goal)
      )
    end)
    |> Enum.filter(& &1)
    |> Enum.map(&length/1)
    |> Enum.min()
  end

  defp build_grid(input) do
    input
    |> Stream.with_index()
    |> Stream.flat_map(fn {ln, i} ->
      String.to_charlist(ln)
      |> Enum.with_index()
      |> Enum.map(fn {v, j} -> {{i, j}, {i, j, v}} end)
    end)
    |> Map.new()
  end

  defp euclidean({x1, y1, _z1}, {x2, y2, _z2}),
    do: ((x1 - x2) ** 2 + (y1 - y2) ** 2) ** 0.5

  defp adj({x, y, z}, grid) do
    grid
    |> Map.take([{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}])
    |> Map.values()
    |> Enum.reject(fn {_i, _j, k} -> k - z > 1 end)
  end
end
