elem(table, index)
----
Gets the element at the zero-based `index` in `tuple`.

It raises `ArgumentError` when index is negatie or it is out of range of 
the tuple elements.

Allowed in guard tests. Inlined by the compiler.

Example
```
tuple = {:foo, :bar, 3}
elem(tuple, 1)
#=> :bar
elem({}, 0)
#=> ** (ArgumentError) argument error
elem({:foo, :bar}, 2)
#=> ** (ArgumentError) argument error
```

