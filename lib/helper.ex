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
end
