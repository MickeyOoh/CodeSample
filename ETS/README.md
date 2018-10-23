ETS(Erlang Term Storage
----
Erlang Term Storage, commonly referred to as ETS, is a powerful storage 
engine built in OTP and available to use in Elixir. 

Overview
----
ETS is a robust in-memory store for Elixir and Erlang objects that comes
included. ETS is capable of storing large amounts of data and offers 
constant time data access.

Creating Tables
----
Tables are crated with `new/2` which accepts a table name, and a set of
options, and returns a table identifier that we can use in subsequent
operation.

```
iex> table = :ets.new(:user_lookup, [:set, :protected])
8212
```

Table types
----
* `set`    -- this is the default type. One value per key. Keys are unique
* `ordered_set` -- Similar to `set` but ordered by Erlang/Elixir term. it
  is important to note that key comparison is different within `ordered_set`
  . Keys need not match so long as they compare equally. 1 and 1.0 are
  considered equal
* `bag` -- Many objects per key but only one instance of each object per key
* `duplicate_log` -- Many objects per key, with duplicates allowed.

Access Controls
----
* `public` - Read/Write available to all processes.
* `pretected` - Read/Write available to all processes. Only writable by owner process. this is the default.
* `private` -- Read/Write limited to owner process.

Race Conditions
----


Inserting data
----
```
iex> :ets.insert(:user_lookup, {"doomsportk", "Sean", ["elixir", "Ruby", "Java"]})
true
```
