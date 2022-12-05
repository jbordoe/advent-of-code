defmodule Helper do
  @moduledoc """
  commonly-used functions
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Helper
    end
  end

  @doc """
  Opens a stream of lines from the given filepath
  with trailing newlines removed

  ## Example

      iex> Helper.stream_lines_from_file("lines.txt")
  """
  def stream_lines_from_file(filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
  end

  @doc """
  Performs a transpose on the given 2D array

  ## Example

    iex> Helper.transpose([[1,2,3],[10,20,30],[11,22,33]])
    [[1,10,11],[2,20,22],[3,30,33]]
  """
  def transpose(arr) do
    arr
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
