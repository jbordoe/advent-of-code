defmodule Aoc20.Day4 do
  @moduledoc """
  Solution for Day Four of Advent of Code
  https://adventofcode.com/2020/day/4
  """
  @required_fields MapSet.new(~w[byr iyr eyr hgt hcl ecl pid])

  def solution1(input) do
    input
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.filter(&has_required_fields?/1)
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.filter(&valid?/1)
    |> Enum.count()
  end

  def valid?(ppt_lines) do
    has_required_fields?(ppt_lines) && fields_valid?(ppt_lines)
  end

  defp has_required_fields?(ppt_lines) do
    ppt_lines
    |> fields()
    |> Enum.map(&List.first/1)
    |> MapSet.new()
    |> superset?(@required_fields)
  end

  defp fields(ppt_lines) do
    ppt_lines
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.split(&1, ":"))
  end

  defp fields_valid?(ppt_lines) do
    ppt_lines
    |> fields()
    |> Stream.map(fn [f, v] -> validate_field(f, v) end)
    |> Enum.all?()
  end

  defp validate_field("byr", <<v::binary-size(4)>>),
    do: String.to_integer(v) |> in_range(1920, 2002)

  defp validate_field("iyr", <<v::binary-size(4)>>),
    do: String.to_integer(v) |> in_range(2010, 2020)

  defp validate_field("eyr", <<v::binary-size(4)>>),
    do: String.to_integer(v) |> in_range(2020, 2030)

  defp validate_field("hgt", <<v::binary-size(3), "cm">>),
    do: String.to_integer(v) |> in_range(150, 193)

  defp validate_field("hgt", <<v::binary-size(2), "in">>),
    do: String.to_integer(v) |> in_range(59, 76)

  defp validate_field("ecl", <<v::binary-size(3)>>), do: v in ~w[amb blu brn gry grn hzl oth]
  defp validate_field("pid", <<v::binary-size(9)>>), do: String.to_integer(v) != :error
  defp validate_field("hcl", <<"#", v::binary-size(6)>>), do: String.match?(v, ~r/[0-9a-f]{6}/)
  defp validate_field("cid", _v), do: true
  defp validate_field(_, _), do: false

  defp in_range(:error, _, _), do: false
  defp in_range(x, min, max), do: x >= min && x <= max

  defp superset?(s1, s2), do: MapSet.subset?(s2, s1)
end
