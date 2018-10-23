defmodule Flowsample1 do
  @moduledoc """
  Documentation for Flowsample1.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Flowsample1.hello
      :world

  """
  def hello do
    :world
  end
  def readflow(filename) do 
    File.stream!(filename, [], :line)
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, map ->
         Map.update(map, word, 1, &(&1 + 1)) end)
    |> Enum.into(%{})
  end
end
