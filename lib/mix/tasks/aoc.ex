defmodule Mix.Tasks.Aoc do
  @moduledoc """
  Run solution code for Advent of Code
  https://adventofcode.com
  """
  use Mix.Task

  def run(_) do
    {args, _} =
      System.argv()
      |> OptionParser.parse!(
        strict: [day: :integer, year: :integer],
        aliases: [d: :day, y: :year]
      )

    "Elixir.Aoc#{args[:year]}.Day#{args[:day]}"
    |> String.to_existing_atom()
    |> apply(:solve, [])
    |> Enum.map(&IO.puts/1)
  end
end
