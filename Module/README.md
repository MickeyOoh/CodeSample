Module
----
Provides functions to deal with modules during compilation time.

It allows a developer to dynamically add, delte and register attributes,
attach documentation and so forth.

Most of the runtime data can be inspected via the `__info__/1` function
attached to each compiled module.

Module attributes
----

@after_compile
---

@before_compile
---

@behaviour
---

```
defmodule URI.Parser do 
  @doc "Defines a default port"
  @callback default_port() :: integer

  @doc "Parses the given URL"
  @callback parse(uri_info :: URI.t) :: URI.t
end

## And then  a module may use it as:
defmodule URI.HTTP do 
  @behaviour URI.Parser
  def default_port(), do: 80
  def parse(info), do: info
end
```

@impl
----
To aid in the correct implementation of behaviours, you may
optionally declare `@impl` for implemented callbacks of a
behaviour. This makes callbacks explicit and can help you to
catch errors in your code.

```
defmodule URI.HTTP do 
  @behaviour URI.parser

  @impl true
  def default_port(), do: 80

  @impl true
  def parse(info), do: info
end
```

