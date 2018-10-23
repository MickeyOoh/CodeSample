# Genstagesample
----
Testing GenStage tool

```
iex -S mix

iex> {:ok, a} = A.start_link(0)
iex> {:ok, b} = B.start_link(2)
iex> {:ok, c} = C.start_link()

iex> GenStage.sync_subscribe(c, to: b)
iex> GenStage.sync_subscribe(b, to: a)
```

Typically, we subscribe from bottom to top. Since A will start
producing items only when B connects to it, we want this subscription
to happen when the whole pipeline is ready. After you subscribe all of them, demand will start flowing upstream and events downstream.
