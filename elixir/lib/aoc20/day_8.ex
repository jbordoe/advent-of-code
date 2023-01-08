defmodule Aoc20.Day8 do
  @moduledoc """
  Solutions for Day Eight of Advent of Code 2020
  https://adventofcode.com/2020/day/8
  """

  def solution1(input) do
    {:loop, acc} = input |> Enum.to_list() |> run()
    acc
  end

  def solution2(input) do
    instructions = Enum.to_list(input)

    Enum.map(0..(length(instructions) - 1), fn i -> List.update_at(instructions, i, &flip/1) end)
    |> Enum.uniq()
    |> Enum.map(&run/1)
    |> Enum.find(&match?({:ok, _}, &1))
    |> elem(1)
  end

  defp run(instructions) do
    Stream.unfold({0, [0]}, fn {acc, [idx | seen] = hist} ->
      if idx in seen || is_nil(Enum.at(instructions, idx)) do
        nil
      else
        {acc, next_idx} = instructions |> Enum.at(idx) |> execute(acc, idx)
        status = if next_idx in hist, do: :loop, else: :ok

        {{status, acc}, {acc, [next_idx | hist]}}
      end
    end)
    |> Enum.at(-1)
  end

  defp execute(<<"nop", _rest::binary>>, acc, i), do: {acc, i + 1}
  defp execute(<<"acc ", amt::binary>>, acc, i), do: {acc + String.to_integer(amt), i + 1}
  defp execute(<<"jmp ", amt::binary>>, acc, i), do: {acc, i + String.to_integer(amt)}

  defp flip(<<"nop", rest::binary>>), do: "jmp" <> rest
  defp flip(<<"jmp", rest::binary>>), do: "nop" <> rest
  defp flip(instruction), do: instruction
end
