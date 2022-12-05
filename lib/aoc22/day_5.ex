defmodule Aoc22.Day5 do
  use Helper

  @moduledoc """
  Solution for Day Five of Advent of Code
  https://adventofcode.com/2022/day/5
  """

  @default_filepath "priv/input/day_5.txt"

  def solve do
    [solution1(), solution2()]
  end

  def solution1(filepath \\ @default_filepath) do
    filepath
    |> prepare()
    |> rearrange()
    |> Enum.map(&List.first/1)
    |> Enum.join()
  end

  def solution2(filepath \\ @default_filepath) do
    filepath
    |> prepare()
    |> rearrange(true)
    |> Enum.map(&List.first/1)
    |> Enum.join()
  end

  defp rearrange({stacks, instructions}, retain_order \\ false) do
    Enum.reduce(
      instructions,
      stacks,
      fn inst, st -> move(st, inst, retain_order) end
    )
  end

  defp move(stacks, %{from: from, n: n, to: to}, retain_order) do
    {crates, source} = Enum.at(stacks, from - 1) |> Enum.split(n)
    crates = if retain_order, do: crates, else: Enum.reverse(crates)

    stacks
    |> List.replace_at(from - 1, source)
    |> List.replace_at(to - 1, crates ++ Enum.at(stacks, to - 1))
  end

  defp prepare(filepath) do
    [crates, _, instructions] =
      filepath
      |> stream_lines_from_file()
      |> Enum.chunk_by(&(&1 == ""))

    {parse_crates(crates), parse_instructions(instructions)}
  end

  defp parse_crates(lines) do
    lines
    # ignore stack numbers
    |> Enum.drop(-1)
    |> Enum.map(fn line ->
      line
      |> String.slice(1..-1)
      |> String.graphemes()
      |> Enum.take_every(4)
    end)
    |> transpose()
    |> Enum.map(fn stack -> Enum.reject(stack, &(&1 == " ")) end)
  end

  defp parse_instructions(lines) do
    lines
    |> Enum.map(fn line ->
      ["move", n, "from", from, "to", to] = String.split(line)

      %{
        from: String.to_integer(from),
        to: String.to_integer(to),
        n: String.to_integer(n)
      }
    end)
  end
end
