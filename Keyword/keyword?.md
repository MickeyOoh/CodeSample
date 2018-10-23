keyword?(term)
----
keyword?(term()) :: boolean()

Return true if `term` is a keyword list; otherwise returns `flase`.

Examples
```
iex> Keyword.keyword?([])
true
iex> Keyword.keyword?([a: 1])
true
iex> Keyword.keyword?([{Foo, 1}])
true
iex> Keyword.keyword?([{}])
false
iex> Keyword.keyword?([:key])
false
iex> Keyword.keyword?(%{})
false
```

