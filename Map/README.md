merge(map1, map2)
----
merge(map(), map()) :: map()
Merges two maps into one

```
iex> Map.merge(%{a: 1, b: 2}, %{a: 3, d: 4})
%{a: 3, b: 2, d: 4}
```
merge(map1, map2, fun)
----
merge(map(), map(), (key(), value(), value() -> value())) :: map()

```
iex> Map.merge(%{a: 1, b: 2}, %{a: 3, d: 4}, fn _k, v1, v2 -> v1 + v2 end)
%{a: 4, b: 2, d: 4}
```


put(map, kye, value)
----
put(map(),key(),value()) :: map()

Puts the given `value` under `key` in `map`.

Examples
```
iex> Map.put(%{a: 1}, :b, 2)
%{a: 1, b: 2}
iex> Map.put(%{a: 1, b: 2}, :a, 3)
%{a: 3, b: 2}
```

update(map, key, initial, fun)
----
update(map(), key(), value(), (value() -> value())) :: map()

Updates the key in map with the given function.

```
iex> Map.update(%{a: 1}, :a, 13, &{&1 * 2})
%{a: 2}
iex> Map.update(%{a: 1}, :b, 11, &(&1 * 2))
%{a: 1, b: 11}

```

