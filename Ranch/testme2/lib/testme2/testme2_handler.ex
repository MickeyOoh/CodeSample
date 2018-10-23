defmodule TestMe2.Handler do 

  def start_link(ref, socket, transport, opts) do 
    pid = spawn_link(__MODULE__, :init, [ref, socket, transport, opts])
    {:ok, pid}
  end

  def init(ref, socket, transport, _opts = []) do 
    IO.puts "init spawn #{inspect ref},#{inspect socket},#{inspect transport}"
    :ok = :ranch.accept_ack(ref)
    loop(socket, transport)
  end

  def loop(socket, transport) do 
    case transport.recv(socket, 0, 5000) do 
      {:ok, data} ->
        IO.puts "received #{inspect data}"
        transport.send(socket, data)
        loop(socket, transport)
      _ ->
        :ok = transport.close(socket)
    end
  end
end
