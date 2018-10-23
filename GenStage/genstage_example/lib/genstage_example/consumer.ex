defmodule GenstageExample.Consumer do 
  use GenStage

  def start_link do 
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end
  def init(state) do 
    {:consumer, state, subscribe_to:
      [GenstageExample.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do 
    IO.puts "2events=>#{inspect events},state=>#{inspect state}"
    for event <- events do 
      IO.inspect({self(), event, state})
    end
    Process.sleep(3000)
    # As a consumer we nerver emit events
    {:noreply, [], state}
  end
end

