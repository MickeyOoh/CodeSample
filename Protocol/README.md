Protobol 
----
So what are they? Protocols are a means of achieving polymorphism in Elixir.
One pain of Erlang is extending an existing API for newly defined types.
To avodi this in Elixir the function is dispatched dynamically based on the
value's type. Elixir comes with a number of protocols built in, for example
the `String.Chars` protocols is responsible for the `to_string/1` function
we've seen used proviously. Let's take a closer look at `to_string/1` with
a quick example:

```
iex> to_string(5)
"5"
iex> to_string(12.4)
"12.4"
iex> to_string("foo")
"foo"

```
As you can see we've called the function on multiple types adn demonstrated
that it work on them all. What if we call `to_string/1` on tuples(or any
types that hasn't implemented `String.Chars`)? 
```
iex> to_string({:foo})
** (Protocol.UndefinedError) protobol String.Chars not implemented for
```

Implementing a protocol
----
We saw that `to_tring/1` has not yet been implemented for tuples, so let's 
add it. To create an inplementation we'll use `defimpl` with our protocol,
and provide the `:for` option, and our type. Let's take a look at how it
might look:
```
defimpl String.Char, for: Tuple do 
  def to_string(tuple) do 
    interior =
      tuple
      |> Tuple.to_list()
      |> Enum.map(&Kernel.to_string/1)
      |> Enum.join(", ")

    "{#{interior}}"
  end
end
```

We know how to implement a protocol but how do we define a new one? For our
example we'll implement `to_atom/1`. Let's see how to do that with 
`defprotocol`:
```


```

