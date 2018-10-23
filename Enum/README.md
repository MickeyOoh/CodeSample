Enum
----

with_index(enumerable, offset \\ 0)
----
with_index(t(), integer()) :: [{element(), index()}]

Returns the enumberable with each elemnet wrapped in a tuple 
alongside its index.
```
iex> Enum.with_index([:a, :b, :c])
[a: 0, b: 1, c: 2]
iex> Enum.with_index([:a, :b, :c:], 3)
[a: 3, b: 4, c: 5]
```

flat_map(enumerable, fun)
-----
flat_map(t(), (element() -> t())) :: list()

Maps the given `fun` over `enumerable` and flattens the result.

This function returns a nwe enumerable built by appending the result
of invoking `fun` on eah elemnet of `enumerable` together;this is similar 
to a combination of `map/2` and `concat/1`.

```
iex> Enum.flat_map([:a, :b, :c], fn(x) -> [x, x] end)
[:a, :a, :b, :b, :c, :c]
iex> Enum.flat_map([{1,3}, {4, 6}], fn({x, y}) -> x..y end)
[1, 2, 3, 4, 5, 6]
```

uniq(enumerable)
----
uniq(t()) :: list()

Enumerates the `enumrable`, removing all duplicated elements.
```
iex> Enum.uniq([1,2,3,3,2,1])
[1,2,3]
```

take_every(enumerable, nth)
-----
take_every(t(), non_reg_integer()) :: list()

Return a list of every `nth` item in the enumerable, starting with
the first element.

```
iex> Enum.take_every(1..10, 2)
[1, 3, 5, 7, 9]
iex> Enum.take_every(1..10, 0)
[]
iex> Enum.take_every([1,2,3], 1)
[1,2,3]

```
