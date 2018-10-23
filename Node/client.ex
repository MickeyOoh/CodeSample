defmodule Client do 
  def start do 
    pid = :global.whereis_name(:server)
    IO.puts "cli pid=>#{inspect pid}"
    #send :global.whereis_name(:server), {self(), "Ping"}
    send pid, {self(), "Ping"}

    receive do 
      {:ok, message} ->
        IO.puts message
    end
  end
end
