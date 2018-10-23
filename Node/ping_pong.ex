defmodule PingPong do 
  def server_start do 
    pid = spawn(__MODULE__, :loop, [])
    IO.puts "ser pid=>#{inspect pid}"
    :global.register_name(:server, pid)
  end

  def loop() do 

    receive do 
      {sender, msg} ->
        IO.puts "received message: #{msg}"

        send sender, {:ok, "#{msg} Pong!!!!!"}
    end
    loop()
  end
end

