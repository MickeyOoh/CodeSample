###
import Supervisor.Spec

pub_children = [
  worker(Registry, [:duplicate, My.Pub, [partitions: System.schedulers_online]]),
]
{:ok, _pub} = Supervisor.start_link(pub_children, strategy: :one_for_one)


### sub 
defmodule My.Sub do 
  use GenServer

  @pub My.Pub

  def init(topics) do 
    IO.puts "#{inspect self()}: init"
    # 
    for topic <- topics, do: Registry.register(@pub, topic, [])
    {:ok, topics}

  end
  def handle_cast(payload, topics) do 
    IO.puts "#{inspect self()}; handle_cast, payload= #{inspect payload}"

    {:noreply, topics}
  end

  def terminate(reason, topics) do 
    IO.puts "#{inspect self()}: terminate, reason = #{inspect reason}"
  end
end

import Supervisor.Spec
sub_children = [
  worker(GenServer, [My.Sub], restart: :transient)
]
{:ok, sub_sup} = Supervisor.start_link(sub_children, strategy: :simple_one_for_one)

a_topic = "foo"
other_topic = "bar"
another_topic = "baz"

{:ok, client1} = Supervisor.start_child(sub_sup, [[a_topic]])
IO.puts "#{inspect client1} subscribes #{a_topic}."

{:ok, client2} = Supervisor.start_child(sub_sup, [[a_topic, other_topic]])
IO.puts "#{inspect client2} subscribes #{a_topic} and #{other_topic}."

{:ok, client3} = Supervisor.start_child(sub_sup, [[other_topic]])
IO.puts "#{inspect client3} subscribes #{other_topic}."
