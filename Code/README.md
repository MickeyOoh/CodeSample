Code
----
Utilities for managing code compilation, code evaluation, and code loading.

This module complements Erlang's `:code module` to add behaviour which is 
specific to Elixir. Almost all of the functions in this module have global
side effects on the behaviour of Elixir


eval_quoted
----
`eval_quoted(quoted, binding \\ [], opts \\ [])
eval_quoted(Macro.t(), list(), Macro.Env.t() | keyword()) ::
{term(), binding :: list()}

