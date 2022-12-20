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
        strict: [day: :integer, year: :integer, profile: :boolean],
        aliases: [d: :day, y: :year]
      )

    %{year: year, day: day} = Map.new(args)
    profile = Keyword.get(args, :profile, false)


    input = stream_lines_from_file("priv/input/20#{year}/day_#{day}.txt")
    module = String.to_existing_atom("Elixir.Aoc#{year}.Day#{day}")

    if profile do
      :fprof.apply(&run_solution_code/2, [module, input])
      :fprof.profile()
      :fprof.analyse()
    else
      run_solution_code(module, input)
    end
  end

  def run_solution_code(module, input) do
    [:solution1, :solution2]
    |> Enum.map(&(apply(module, &1, [input])))
    |> Enum.map(&IO.puts/1)
  end
end
