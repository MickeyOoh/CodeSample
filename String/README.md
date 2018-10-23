String
=====

1.at(string, position)

2.capitalize(string, mode \\ :default)

3.chunk(string, trait)
  chunk(t(), :valid | :printable) :: [t()]

  Converts the first character in the given string to uppercase and the remainder to lowercase according to mode

*  :valid - the string is split into chunks of valid and invalid
    character sequences
*  :printable - the string is split into chunks of printable and non-printable character sequences.

```
iex> String.chunk(<<?a, ?b, ?c, 0>>, :valid)
["abc\0"]
iex> String.chunk(<<?a, ?b, ?c, 0, 0xffff::utf16>>, :valid)
["abc\0", <<0xFFFF::utf16>>]
iex> String.chunk(<<?a, ?b, ?c, 0, 0x0FFFF::utf8>>, :printable)
["abc", <<0, 0xFFFF::utf8>>]
```

4. 

trim(string), trim(string, to_trim)
----
Returns a string where all leading and trailing Unicode whitespaces
have been removed.

```
iex> String.trim("\n  abc\n  ")
"abc"
iex> String.trim("a  abc  a", "a")
"   abc  "
```

trim_leading(string), trim_leading(string, to_trim)
----
Returns a string where all leading Unicode whitespaces have been removed.
```
iex> String.trim_leading("\n  abc   ")
"abc    "
iex> String.trim_leading("__ abc _", "_")
" abc _"
iex> String.trim_leading("1 abc", "11")
"1 abc"
```

trim_trailing(string), trim_trailing(string, to_trim)
----
trim_trailing(t()) :: t()
Returns a string where all trailing Unicoe whitespaces has been removed.

```
iex> String.trim_trailing("   abc\n  ")
"   abc"
iex> String.trim_trailing("_ abc ___", "_")
"_ abc "
iex> String.trim_trailing("abc 1", "11")
"abc 1"
```

graphemes(string)
----
graphemes(t()) :: [grapheme()]

Returns Unicode graphemes in the string as per Extended Graphemes Cluster
algorithm.
The algorithm is outlined in the Unicode Standard Annex #29, Unicode Text
Segmentation.


split(string, pattern, options \\ [])
----
split(t(), pattern() | Regex.t(), keyword()) :: [t()]

Options
*  :parts ( or :infinity) - the string is split into at most as many parts
    as this option sepcifies.
*  :trim(boolean) - if true, empty strings are removed from the resulting list.

```

```
