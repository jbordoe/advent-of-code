defmodule Mix.Tasks.Aoc do
  @moduledoc """
  Run solution code for Advent of Code
  https://adventofcode.com/2022/
  """
  use Mix.Task

  def run(_) do
    {args, _} =
      System.argv()
      |> OptionParser.parse!(
        strict: [day: :integer],
        aliases: [d: :day]
      )

    "Elixir.Aoc22.Day#{args[:day]}"
    |> String.to_existing_atom()
    |> apply(:solve, [])
    |> Enum.map(&IO.puts/1)
  end
end
