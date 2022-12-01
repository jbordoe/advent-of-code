defmodule Mix.Tasks.Day1 do
  @moduledoc """
  Run solution code for Advent of Code
  https://adventofcode.com/2022/
  """
  use Mix.Task

  def run(_) do
    Aoc22.DayOne.solution("priv/input/day_1.txt")
    |> IO.puts
  end
end
