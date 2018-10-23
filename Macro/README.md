Macro
----

Custom Sigils
----
To create a custom sigil, define a function with the name `sigil_{identifier}` that takes two arguments.
The first argument will be the string, the second will be a charlist containing any modifiers. If the sigil is lower case(such as `sigil_x`) then the string argument will allow interpolation.

[example.exs](example.exs)

Types
---
expr()
expr() :: {expr() | atom(), keyword(), atom() | [t()]}
Represents expressions in the AST

[example.exs](example.exs)

Types
---
```
expr()
expr() :: {expr() | atom(), keyword(), atom() | [t()]}
```
Represents expressions in the AST
```
literal()
literal() ::
  atom() | number() | binary() | (... -> any()) | {t(), t()} | [t()]
```

```
t()
t() :: expr() | interal()
```

Functions
----

```
escape(expr, opts \\ [])
escape(term(), keyword()) :: Macro.t()
```
Recursively escapes a value so it can be inserted into a syntax tree.
One may pass `unquote: true` to `escape/2` which leaves `unquote/1`
statements unescaped, effectively unquoting the contents on escape.

```
iex> Macro.escape(:foo)
:foo
iex> Macro.escape({:a, :b, :c})
{:{}, [], [:a, :b, :c]}

iex> Macro.escape({:unquote, [], [1]}, unquote: true)
1
```

