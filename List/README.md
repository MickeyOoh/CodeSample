
foldl(list, acc ,fun)
----
foldl([elem], ac, (elem, acc -> acc)) :: acc when elem: var, acc: var

folds(reduces) the given list formt he left with a function, Requires 
an accumulator.

```
iex> List.foldl([5,5], 10, fn(x, acc) -> x + acc end)
20
iex> List.foldl([1,2,3,4], 0, fn(x, acc) -> x - acc end)
2
```

foldr(list, acc ,fun)
----
foldr([elem], acc,(elem, acc -> acc)) :: acc when elem: var, acc: var

Folds(reduces) the given lsit from the right with a function. Requires 
an accumulator.

```
iex> List.foldr([1,2,3,4], 0, fn(x, acc) -> x - acc end)
-2
```

