defmodule A do 
  use GenStage

  def start_link(number) do 
    IO.puts "start_link A, #{number}"
    GenStage.start_link(A, number)
  end

  def init(counter) do 
    IO.puts "init A, #{counter}"
    {:producer, counter}
  end

  def handle_demand(demand, counter) when demand > 0 do
    # If the counter is 3 and we ask for 2 items, we will
    # emit the items 3 and 4, and set the state to 5.
    IO.puts "handle_demand A, #{inspect demand}:#{counter}"

    events = Enum.to_list(counter..counter+demand-1)
    {:noreply, events, counter + demand}
  end
end

defmodule B do 
  use GenStage

  def start_link(number) do
    IO.puts "start_link B #{number}"
    GenStage.start_link(B, number)
  end

  def init(number) do
    IO.puts "init B #{number}"
    {:producer_consumer, number}
  end

  def handle_events(events, _from, number) do
    IO.puts "handle_events B #{inspect events}, #{number}"
    events = Enum.map(events, & &1 * number)
    {:noreply, events, number}
  end
end

defmodule C do
  use GenStage

  #def start_link() do
  #  GenStage.start_link(C, :ok)
  #end
  def start_link(sleeping_time) do
    GenStage.start_link(C, sleeping_time)
  end

  #def init(:ok) do
  #  IO.puts "init C"
  #  {:consumer, :the_state_does_not_matter}
  #end
  def init(sleeping_time) do
    IO.puts "init C time:#{sleeping_time}"
    {:consumer, sleeping_time}
  end

  #def handle_events(events, _from, state) do
  #  IO.puts "handle_events #{inspect events} #{inspect state}"
  #  Process.sleep(1000) # Wait for a second.
  #  IO.inspect(events)  # Inspect the events.
  #  # We are a consumer, so we would never emit items.
  #  {:noreply, [], state}
  #end
  def handle_events(events, _from, sleeping_time) do
    IO.puts "handle_events #{inspect events} #{sleeping_time}"
    Process.sleep(sleeping_time) # Wait for a second.
    IO.inspect(events)  # Inspect the events.
    # We are a consumer, so we would never emit items.
    {:noreply, [], sleeping_time}
  end
end

# {:ok, a} = A.start_link(0)  # starting from zero
# {:ok, b} = B.start_link(2)  # mltiply by 2
## {:ok, c} = C.start_link()   # state does not matter
# {:ok, c} = C.start_link(1000)   # state does not matter

# GenStage.sync_subscribe(c, to: b)
# GenStage.sync_subscribe(b, to: a)

