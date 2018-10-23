MapSet
-----
`MapSet` is the "go to" set data structure in Elixir. A set can be
constructed using `MapSet.new/0`:
```
iex> MapSet.new
#MapSet<[]>
```
A set can contain any kind of elements, and elements in a set
don't have to be of the same type.
By definition, sets can't contain duplicate elements: when inserting an 
element in a set where it's already present, the insertion is simply
a no-op.




disjoint?(map_set1, map_set2)
-----
disjoint?(t(), t()) :: boolean()

Checks if `map_set1` and `map_set2` no members in common.

