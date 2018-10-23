defmodule FantasyTeam.Basic do 
  def start_link do 
    spawn_link(__MODULE__, :loop, [%{}])
  end

  def loop(state) do 
    receive do 
      {:add, name} ->
         player = FantasyTeam.Pl 
