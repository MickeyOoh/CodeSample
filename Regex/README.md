Regex
-----

Capture
----

* :all - all captured subpatterns including the complete matching string
* :first - only the first captured subpattern, which is always the complete 
   matching part of the string; all explicitly captured subpatterns are
   discarded
* :all_but_first - all but the first matching subpattern,
* :none  - does not return matching subpatterns at all
* :all_names - captures all names in the Regex
* list(binary) - a list of named captures to capture

compile(source, options \\ ""), compile!(source, options \\ "")
----
compile(binary(), binary() | [term()) :: {:ok, t()} | {:error, any()}

Compiles the regular expression

```
iex> Regex.compile("foo")
{:ok, -r"foo"}

iex> Regex.compile("*foo")
{:error, {'nothing to repeat', 0}}
```

run(regex, sring, options \\ [])
----
run(t(), binary(), [term()]) :: nil | [binary()] | [{integer(), integer()]}]

Runs the regular expression against the given string until the first match.
It returns a list with all captures or nil if no match occurred.




Regularation Expression 

Bracket expressions - []

[abc]    - matches a string that has either an `a` or a `b` or a `c`
           is the same as `a|b|c`




/([abc])\1  - using `\1` it matches *the same* text that was matched by 
              the first capturing group.

   
