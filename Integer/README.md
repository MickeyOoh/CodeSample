Integer
----

parse(binary, base \\ 10)
-----
`parse(binary(), 2..36) :: {integer(), binary()} | :error`
Parses a text representation of an integer.
An optional `base` to the corresponding integer can be provided.

```
iex> Ineger.parse("34")
{34, ""}
iex> Integer.parse("34.5")
{34, ".5"}
iex> Integer.parse("three")
:error
iex> Integer.parse("34", 10)
{34, ""}
iex> Integer.parse("f4", 16)
{244, ""}
iex> Integer.parse("Awww++", 36)
{509216, "++"}
iex> Integer.parse("fab", 10)
:error
```
