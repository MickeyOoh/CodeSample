handle_call(request, from, state)
----
handle_call(request :: term(), from(), state :: term()) ::
   {:reply,   reply,     new_state}
 | {:reply,   reply,     new_state, timeout() | :hibernate)
 | {:noreply, new_state}
 | {:noreply, new_state,            timeout() | :hibernate}
 | {:stop,    reason,    reply, new_state}
 | {:stop,    reason,           new_state}
when reply: term(), new_state: term(), reason: term()

Invoked to handle synchronous `call/3` messages. `call/3` will block
until a reply is received(unless the call times out or nodes are 
disconnected).
`request` is the request message send by a `call/3`, from is a 
2-tuple containing the caller's PID and a term that uniquely
identifies the call, and `state` is the current state of the
`GenServer`.

1. {:reply,   reply,     new_state}
     returning sends the response `reply` to the caller and continues
     the loop with new state `new_state`.
2. {:reply,   reply,     new_state, timeout())
     returning is similar to `{:reply,   reply,     new_state}` 
     except handle_info(:timeout, new_state) will be called after
     `timeout` milliseconds if no messages are received.
3. {:reply,   reply,     new_state, :hibernate)

