update_in(path, fun)
---
Updates a nested structure via the given `path`.

```
iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
iex> update_in(users["john"][:age], &(&1 + 1))
%{"john" => %{age: 28}, "meg" => %{age: 23}}

iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
iex> update_in(users["john"].age, &(&1 + 1))
%{"john" => %{age: 28}, "meg" => %{age: 23}}

```



left && right
----
Provides a short-circuit operator that ealueates and returns the
second expression only if the first one evaluates to `true`
Returns the first expression otherwise.

Not allowed in guard cluases.

```
iex> Enum.empty?([]) && Enum.empty?([])
true
iex> List.first([]) && true
nil
iex> Enum.empty?([]) && List.first([1])
1
iex> false && throw(:bad)
false
```
