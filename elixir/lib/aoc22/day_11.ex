defmodule Aoc22.Day11 do
  @moduledoc """
  Solution for Day Eleven of Advent of Code 2022
  https://adventofcode.com/2022/day/11
  """
  defmodule Monkey do
    defstruct id: nil, inspect: nil, test: nil, divisor: nil, items: []
  end

  def solution1(input), do: monkey_business(input, 20, &div(&1, 3))
  def solution2(input, rounds \\ 10_000), do: monkey_business(input, rounds)

  def monkey_business(input, n_rounds, worry_div_fn \\ nil) do
    monkeys = input |> Stream.chunk_every(7) |> Enum.map(&parse_monkey/1)

    worry_div_fn =
      if is_nil(worry_div_fn) do
        divisor_product = Enum.map(monkeys, & &1.divisor) |> Enum.product()
        &rem(&1, divisor_product)
      else
        worry_div_fn
      end

    monkeys
    |> Enum.flat_map(fn %{items: its, id: id} -> Enum.map(its, &{&1, id}) end)
    |> Stream.flat_map(fn item -> trace_item(item, monkeys, n_rounds, worry_div_fn) end)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  # genrate a stream of the monkeys in possesion of the item as it's passed around
  # (along with round counter)
  defp trace_item({item, initial_monkey_id}, monkeys, n_rounds, worry_div_fn) do
    Stream.unfold({n_rounds, item, initial_monkey_id}, fn
      {n, it, current_monkey_id} ->
        {next_monkey_id, it_updated} =
          monkeys
          |> Enum.at(current_monkey_id)
          |> then(fn monkey -> monkey.inspect.(it, worry_div_fn) end)

        nextn = if next_monkey_id < current_monkey_id, do: n - 1, else: n
        {{current_monkey_id, n}, {nextn, it_updated, next_monkey_id}}
    end)
    |> Stream.take_while(fn {_, n} -> n > 0 end)
    |> Stream.map(fn {mid, _} -> mid end)
  end

  defp parse_monkey(chunk) do
    [[id | _], [_, items], [_, opstr], [_, test], [_, iftrue], [_, iffalse] | _] =
      Enum.map(chunk, &String.split(&1, ~r/:\s?/))

    items = String.split(items, ", ") |> Enum.map(&String.to_integer/1)

    [id, divisor, iftrue, iffalse] =
      [id, test, iftrue, iffalse]
      |> Enum.map(&(&1 |> String.split() |> List.last() |> String.to_integer()))

    op = parse_functions(opstr, iftrue, iffalse, divisor)
    %Monkey{id: id, inspect: op, divisor: divisor, items: items}
  end

  # Create a function that takes an item with a given worry level
  # and returns the monkey to which the item will be thrown, along with its new worry level
  defp parse_functions(
         <<"new = old ", op::binary-size(1), " ", rest::binary>>,
         iftrue,
         iffalse,
         test_divisor
       ) do
    testfn = fn worry, div_fn ->
      worry = div_fn.(worry)
      target = if rem(worry, test_divisor) == 0, do: iftrue, else: iffalse
      {target, worry}
    end

    case rest do
      "old" ->
        &(apply(Kernel, String.to_existing_atom(op), [&1, &1]) |> testfn.(&2))

      n ->
        n = String.to_integer(n)
        &(apply(Kernel, String.to_existing_atom(op), [&1, n]) |> testfn.(&2))
    end
  end
end
