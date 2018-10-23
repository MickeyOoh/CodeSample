defmodule Shortener.Worker do
  use GenServer

  def start_link(table, opts \\ []) do 
    GenServer.start_link(__MODULE__, table, opts)
  end

  def shorten(pid, url, short) do 
    GenServer.call(pid, {:shorten, url, short})
  end
  def url(pid, short) do 
    GenServer.call(pid, {:url, short})
  end

  # Call backs

  def init(table) do 
    {:ok, table}
  end

  def handle_call({:shorten, short, url}, _from, table) do 
    case Map.fetch(table, short) do 
      :error ->
        {:reply, :ok, Map.put(state, short, url)}
      _     ->
        {:reply, {:error, :dupalias}, state}
    end
  end
end
