defmodule TestMe2.Worker do 
  def start_link() do 
    opts = [port: 5555]
    {:ok, _} = :ranch.start_listener(:TestMe2, 100, :ranch_tcp, opts, TestMe2.Handler, [])
  end
end

