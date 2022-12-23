defmodule Aoc22.Day21 do
  @moduledoc """
  Solutions for Day Twenty-One of Advent of Code 2022
  https://adventofcode.com/2022/day/21
  """

  def solution1(input) do
    input
    |> Enum.map(fn ln ->
      case String.split(ln, [": ", " "]) do
        [var, vara, op, varb] ->
          {var, {vara, op, varb}}

        [var, val] ->
          {var, String.to_integer(val)}
      end
    end)
    |> Map.new()
    |> resolve()
    |> trunc()
  end

  def solution2(input) do
    input
    |> Enum.map(fn ln ->
      case String.split(ln, [": ", " "]) do
        ["root", vara, _op, varb] ->
          {"root", {vara, "-", varb}}

        [var, vara, op, varb] ->
          {var, {vara, op, varb}}

        [var, val] ->
          {var, String.to_integer(val)}
      end
    end)
    |> Map.new()
    |> find_humn()
  end

  defp find_humn(vars) do
    [r, rd] = Enum.map([0, 1], &resolve(Map.put(vars, "humn", &1)))

    sign =
      cond do
        r > 0 and rd > r -> -1
        r > 0 and rd < r -> 1
        r < 0 and rd > r -> 1
        r < 0 and rd < r -> -1
      end

    trunc(find_zero(vars, 1, 1, r, sign, 2))
  end

  defp find_zero(vars, x, step, prev, sign, step_factor) do
    next = max(1, step * step_factor) * sign
    
    case resolve(Map.put(vars, "humn", x)) do
      0.0 ->
        x

      # origin is between this x and previous x
      r when (r > 0 and prev < 0) or (r < 0 and prev > 0) ->
        find_zero(vars, x - next, next, r, -sign, 1/step_factor)

      r ->
        find_zero(vars, x + next, next, r, sign, step_factor)
    end
  end

  defp resolve(vars), do: resolve(vars, "root")
  defp resolve(_vars, val) when is_number(val), do: val
  defp resolve(vars, {v1, "+", v2}), do: resolve(vars, v1) + resolve(vars, v2)
  defp resolve(vars, {v1, "-", v2}), do: resolve(vars, v1) - resolve(vars, v2)
  defp resolve(vars, {v1, "*", v2}), do: resolve(vars, v1) * resolve(vars, v2)
  defp resolve(vars, {v1, "/", v2}), do: resolve(vars, v1) / resolve(vars, v2)
  defp resolve(vars, var), do: resolve(vars, Map.get(vars, var))
end
