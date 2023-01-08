defmodule Aoc22.Day13 do
  @moduledoc """
  Solutions for Day Thirteen of Advent of Code 2022
  https://adventofcode.com/2022/day/13
  """

  def solution1(input) do
    input
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&parse/1)
    |> Stream.chunk_every(2)
    |> Stream.map(&in_order?/1)
    |> Stream.with_index()
    |> Enum.reduce(0, fn
      {true, i}, acc -> acc + 1 + i
      {false, _}, acc -> acc
    end)
  end

  def solution2(input) do
    input
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&parse/1)
    |> Stream.concat([[[2]], [[6]]])
    |> Enum.sort(&compare/2)
    |> Enum.with_index()
    |> Enum.filter(fn {packet, _i} -> packet in [[[2]], [[6]]] end)
    |> Enum.map(&(elem(&1, 1) + 1))
    |> Enum.product()
  end

  def parse(ln), do: parse([:start], ln, [[]])

  def parse([:start], "", [[acc]]), do: deep_reverse(acc)

  def parse([:start] = st, <<"[", rest::binary>>, [[]]) do
    parse([:ls | st], rest, [[], []])
  end

  def parse([:ls | _] = st, <<"[", rest::binary>>, acc) do
    parse([:ls | st], rest, [[] | acc])
  end

  def parse([:ls | st], <<"]", rest::binary>>, [current, prev | acc]) do
    parse(st, rest, [[current | prev] | acc])
  end

  def parse([:ls | _] = st, <<",", rest::binary>>, acc) do
    parse(st, rest, acc)
  end

  def parse([:ls | _] = st, <<c::binary-size(1), rest::binary>>, [curr | acc]) do
    parse([:n | st], rest, [[c | curr] | acc])
  end

  def parse([:n, _ | st], <<"]", rest::binary>>, [[n | curr], prev | acc]) do
    parse(st, rest, [[[String.to_integer(n) | curr] | prev] | acc])
  end

  def parse([:n | st], <<",", rest::binary>>, [[n | curr] | acc]) do
    parse(st, rest, [[String.to_integer(n) | curr] | acc])
  end

  def parse([:n | _] = st, <<c::binary-size(1), rest::binary>>, [[n | curr] | acc]) do
    parse(st, rest, [[n <> c | curr] | acc])
  end

  def parse(_, _, _), do: raise("Invalid input string")

  defp in_order?([l, r]), do: compare(l, r) in [nil, true]

  defp compare([], [_h | _t]), do: true
  defp compare([_h | _t], []), do: false

  defp compare([l | restl], [r | restr]) do
    case compare(l, r) do
      nil -> compare(restl, restr)
      res -> res
    end
  end

  defp compare(val, val), do: nil
  defp compare(l, r) when is_integer(l) and is_integer(r), do: l < r
  defp compare(l, r) when is_integer(l), do: compare([l], r)
  defp compare(l, r) when is_integer(r), do: compare(l, [r])

  defp compare(l, r) do
    IO.inspect(l)
    IO.inspect(r)
    raise "Unexpected state!"
  end

  defp deep_reverse(list), do: deep_reverse(list, [])
  defp deep_reverse([], acc), do: acc
  defp deep_reverse([h | t], acc), do: deep_reverse(t, [deep_reverse(h) | acc])
  defp deep_reverse(el, _acc), do: el
end
