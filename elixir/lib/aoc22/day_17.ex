defmodule Aoc22.Day17 do
  @moduledoc """
  Solutions for Day Seventeen of Advent of Code 2022
  https://adventofcode.com/2022/day/17
  """

  import Bitwise

  @shapes [
    "####",
    """
    .#.
    ###
    .#.\
    """,
    """
    ..#
    ..#
    ###\
    """,
    """
    #
    #
    #
    #\
    """,
    """
    ##
    ##\
    """
  ]

  @table :stash

  def solution1(input) do
    stash_moves(input)
    
    width = 7
    n_shapes = 2022
    grid = 0

    @shapes 
    |> Enum.map(&parse_shape_string(&1, width))
    |> Stream.cycle()
    |> Enum.take(n_shapes)
    |> drop_shapes(grid, width, [])
    |> plot(width)
    |> max_filled_row(width)
  end

  def solution2(input) do
    stash_moves(input)
    
    width = 7
    n_shapes = 100
    grid = 0

    @shapes 
    |> Enum.map(&parse_shape_string(&1, width))
    |> Stream.cycle()
    |> Enum.take(n_shapes)
    |> Enum.scan(grid, fn shape, gd ->
      drop_shapes([shape], gd, width, [])
    end)
    |> IO.inspect
  end

  defp drop_shapes([], grid, _, _), do: grid

  defp drop_shapes([shape|shapes], grid, width, moves) do
    start = init_shape(grid, width, shape)
    {updated_grid, moves} = drop_shape(grid, start, width, moves)
    drop_shapes(shapes, updated_grid, width, moves)
  end

  defp drop_shape(grid, shape, width, []), do:
    drop_shape(grid, shape, width, fetch_moves())

  defp drop_shape(grid, shape, width, [next_move|moves]) do
    case move(grid, shape, width, next_move) do
      {gd, :halt} -> {gd, moves}
      {gd, shape_moved} -> drop_shape(gd, shape_moved, width, moves)
    end
  end
    
  defp move(grid, shape, width, "v") do
    moved = shape >>> width

    # bottom boundary breached
    if moved <<< width != shape do
      {grid ||| shape, :halt}
    else
      if band(grid, moved) == 0,
        do: {grid, moved},
        else: {grid ||| shape, :halt}
    end
  end

  defp move(grid, shape, width, "<") do
    moved = shape <<< 1

    # left boundary breached
    next = if get_column(moved, width, width-1) > 0 do
      shape
    else
      # check for overlap
      if band(grid, moved) == 0, do: moved, else: shape
    end
    move(grid, next, width, "v")
  end

  defp move(grid, shape, width, ">") do
    moved = shape >>> 1

    # right boundary breached
    next = if get_column(moved, width, 0) > 0 do 
      shape
    else
      # check for overlap
      if band(grid, moved) == 0, do: moved, else: shape
    end
    move(grid, next, width, "v")
  end

  defp init_shape(grid, width, shape) do
    height = max_filled_row(grid, width) + 3
    shape <<< ((height * width) - 2)
  end

  defp parse_shape_string(str, width) do
    str
    |> String.replace(" ", "")
    |> String.replace(".", "0")
    |> String.replace("#", "1")
    |> String.split("\n")
    |> Enum.map(&String.pad_trailing(&1, width, "0"))
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp stash_moves(input) do
    moves = String.graphemes(Enum.at(input, 0))

    :ets.new(@table, [:named_table, :public, read_concurrency: true])
    :ets.insert(@table, {:moves, moves})
  end

  defp fetch_moves() do 
    [moves: moves] = :ets.lookup(@table, :moves)
    moves
  end

  defp max_filled_row(grid, width), do: max_filled_row(grid, width, 0) 
  defp max_filled_row(0, _width, n), do: n
  defp max_filled_row(grid, width, n), do: max_filled_row(grid >>> width, width, n+1)

  # TODO: def a smarter way to do this
  defp get_column(grid, width, col_num) do
    mask = 1 <<< (width - (col_num+1))
    apply_row_mask(grid, mask, width)
  end

  defp apply_row_mask(0, _, _), do: 0
    defp apply_row_mask(grid, mask, width),
    do: (grid &&& mask) ||| (apply_row_mask(grid >>> width, mask, width) <<< 1)

  defp plot(grid, width) do
    bstr = Integer.to_string(grid, 2)
    # pad so we always plot at least 5 rows
    n_rows = max(5, max_filled_row(grid, width) + 1)
    plotted =
      bstr 
      |> String.pad_leading(n_rows * width, "0")
      |> String.graphemes()
      |> Enum.map(&Map.get(%{"1" => "█", "0" => "░"}, &1))
      |> Enum.chunk_every(width)
      |> Enum.map(&("║" <> String.pad_leading(Enum.join(&1), width, "░") <> "║"))
      |> Enum.concat(["╚" <> String.duplicate("═", width) <> "╝\n"])

    ["╔" <> String.duplicate("═", width) <> "╗"]
    |> Enum.concat(plotted)
    |> Enum.join("\n")
    |> IO.puts()

    grid
  end
end
