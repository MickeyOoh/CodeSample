Three directives for types
-----
* @type -- simple, public type. Internal sructure of type is public
* @typep - type is priveate and could be used only inte module hwere is defined.
* @opaque - type is public, but internal structure is private.


Documentation of types
----

```
defmodule Examples do 
  @typedoc """
     Type that represents Examples struct with :first as integer and : last as integer.
  """
  @type t :: %Examples{first: integer, last: integer}

end
```

Behaviours
----

Uses
---
Sometimes you want modules to share a public API, the solution for this in Elixir is behaviours. Behaviours perform two primary roles:
* Defining a set of functions that must be implemented
* Checking whether that set was actually implemented

Elixi includes a number of behaviours such as `GenServer`, but we'll focus on creating our own instead.

Defining a Behaviour
---
To better understand behaviours let's implement one for a worker module.
These workers will be expected to implement two functions:
* init/1
* perform/2

in order to accomplish this, we'll use the `@callback` directive with syntax
similar to `@spec`. This defines a required function: for macros we can use
`@macrocallback`. 
```
defmodule Example.Worker do 
  @callback init(state :: term) :: {:ok, new_state :: term} | {:error, reason :: term}
  @callback perform(args :: term, state :: term) ::
        {:ok, result :: term, new_state :: term}
        | {:error, reason :: term, new_state :: term}
end
```
Here we've defined `init/1` as accepting any value and returning a tuple of
either `{:ok, state}` or `{:error, reason}`, this is a pretty standard initialzation. 
Our `perfrom/2` function will receive some arguments for the worker along with the state we initialized, we'll expect
