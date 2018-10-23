Registry
----
A lical, decentralized and scalable key-value process storage.

It allows developers to lookup one or more processes with a given key.
If the registry has `:unique` keys, a key points to 0 or 1 processes.
If the registry allows `:duplicate` keys, a single key may point to
any number of porcesses. In both cases, different keys counld identify 
the same process.


Using as a dispatcher
----
`Registry` has a dispatch mechanism that allows developers to implement
custom dispath logic triggered from the caller. For example, let's say
we have a duplicate registry started as so:

```
{:ok, _} = Registry.start_link(keys: :duplicate, name: Registry.DispatcherTest)
```

