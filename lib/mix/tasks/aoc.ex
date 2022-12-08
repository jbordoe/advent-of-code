defmodule Mix.Tasks.Aoc do
  @moduledoc """
  Run solution code for Advent of Code
  https://adventofcode.com
  """
  use Mix.Task
  use Helper

  def run(_) do
    {args, _} =
      System.argv()
      |> OptionParser.parse!(
        strict: [day: :integer, year: :integer],
        aliases: [d: :day, y: :year]
      )

    %{year: year, day: day} = args
    input = stream_lines_from_file("priv/input/20#{year}/day_#{day}.txt")
    module = String.to_existing_atom("Elixir.Aoc#{year}.Day#{day}")
    [:solution1, :solution2]
    |> Enum.map(&(apply(module, &1, [input])))
    |> Enum.map(&IO.puts/1)
  end
end
