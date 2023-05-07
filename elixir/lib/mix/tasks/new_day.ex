defmodule Mix.Tasks.NewDay do
  @moduledoc """
  Create boilerplate for Advent of Code solution code
  """
  use Mix.Task
  use Helper

  @module_template """
defmodule Aoc{YEAR}.Day{DAY} do
  @moduledoc """
  Solutions for Day {DAY} of Advent of Code 20{YEAR}
  https://adventofcode.com/20{YEAR}/day/{DAY}
  \"""

  def solution1(input) do
    input 
  end

  def solution2(input) do
    input
  end
end\
"""

  @test_template """
defmodule Aoc{YEAR}.Day{DAY}.Test do
  use ExUnit.Case
  doctest Aoc{YEAR}.Day{DAY}
  alias Aoc{YEAR}.Day{DAY}

  @fixture "test/fixtures/20{YEAR}/day_{DAY}.txt"

  test "#solution1 gets the right answer" do
    assert nil == Day{DAY}.solution1(input())
  end

  test "#solution2 gets the right answer" do
    assert nil == Day{DAY}.solution2(input())
  end
  
  defp input(), do: Helper.stream_lines_from_file(@fixture)
end
"""
  def run(_) do
    {args, _} =
      System.argv()
      |> OptionParser.parse!(
        strict: [day: :integer, year: :integer],
        aliases: [d: :day, y: :year]
      )

      # TODO: validate input
    %{year: year, day: day} = Map.new(args)
    info(IO.ANSI.underline() <> "Creating files for Advent of Code 20#{year}, Day #{day}")
    
    module_dir = create_dir("lib/aoc#{year}")
    test_dir = create_dir("test/aoc#{year}")
    _fixture_dir = create_dir("test/fixtures/20#{year}")
    _input_dir = create_dir("../priv/input/20#{year}")

    mod = @module_template |> String.replace("{DAY}", "#{day}") |> String.replace("{YEAR}", "#{year}")
    tst = @test_template |> String.replace("{DAY}", "#{day}") |> String.replace("{YEAR}", "#{year}")
    create_file("#{module_dir}/day_#{day}.ex", mod)
    create_file("#{test_dir}/day_#{day}_test.exs", tst)

    success("Done!")
  end

  defp create_dir(dirpath), do: create(:directory, dirpath)
  defp create_file(filepath, contents), do: create(:file, filepath, contents)

  defp create(type, path, contents \\ nil) do
    unless File.exists?(path) do
      info("Creating #{type} " <> IO.ANSI.bright() <> path)
      case type do
        :file -> File.write(path, contents)
        :directory -> File.mkdir(path)
      end
    else
      warn("#{type} " <> IO.ANSI.bright() <> "#{path}" <> IO.ANSI.normal() <> " exists")
    end
    path
  end


  defp info(str), do: IO.puts(IO.ANSI.color(3, 1, 5) <> str <> IO.ANSI.reset())
  #defp log(str), do: IO.puts(IO.ANSI.light_black() <> str <> IO.ANSI.reset())
  #  defp log(str), do: IO.puts(IO.ANSI.light_black() <> str <> IO.ANSI.reset())
  defp warn(str), do: IO.puts(IO.ANSI.color(5, 4, 2) <> str <> IO.ANSI.reset())
  defp success(str), do: IO.puts(IO.ANSI.color(3, 5, 1) <> IO.ANSI.bright <> str <> IO.ANSI.reset())
  #  defp err(str), do: IO.puts(IO.ANSI.light_red() <> str <> IO.ANSI.reset())
end

