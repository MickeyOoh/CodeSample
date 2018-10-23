supervisor behaviour
----







Child specification
----
the child specification describes how the supervisor starts, shuts down, and
restarts child processes.
The child specification contains 6 keys. The first two are required, and the
remaining ones are optional:

* `:id` - any term used to identify the child specification internally by
          defaults to the given module. In the case of conflicting `:id` 
          values, the supervisor will refuse to initialize and require
          explicit IDs. This key is required.
* `:start` - a tuple with the module-function-args to be invoked to start
           the child process. This key is required

* `:restart`
* `:shutdown`
* `:type`


Shutdown values(:shutdown)
----


Restart values(:restart)
-----

child_spec/1
-----
When starting a supervisor, we pass a list of child specifications. Those
specifiations are maps that tell how the supervisor should start, stop,
and restart each of its children:
```
%{
  id: Stack,
  start: {Stack, :start_link, [[:hello]]}
}
```


child_spec(module_or_map, overrides)
----
child_spec(child_spec() | {module(), arg :: term()} | module(), keyword())
        :: child_spec()

Builds and overrides a child specification.

Similar to `start_link/2` and `init/2`, it expects a `module`, `{module, arg}`
or a map as the child specification. If a module is given, the specification
is retrieved by calling `module.child_spec`(arg).

After the child specification is retrieved, the fields on `overrides` are
directly applied on the child spec. If `overrides` has keys that do not map
to any child specification field, an error is raised.

Examples
This function is often used to set an `:id` option when the same module
needs to be started multiple times in the supervision tree:

```
Supervisor.child_spec({Agent, fn -> :ok end}, id: {Agent, 1})
#=> %{
  id: {Agent, 1},
  start: {Agent, :start_link, [#Function<20.127694169/0 in :erl_eval.expr/5>]}
}
```



