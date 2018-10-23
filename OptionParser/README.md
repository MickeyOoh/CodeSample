OptionParser
----

parse(argv, opts \\ [])
parse(argv(), options()) :: {parsed(), argv(), errors()}

Parse `agrv` into a keyword list.

It returns a three-element tuple with the form `{parsed, args, invalid}`
where:

* parsed is keyword list of parsed switches with {switch_name, value} tuples
  in it; switch_name is the atom representing the switch name while value is
  the value for that switch parsed according to `opts`(see the "example" section for more information)
* args is a list 
* invalid is a list of invalid options as {option_name, value} where
  `option_name` is the raw option and `value` is nil if the option wasn't expected or the string value if the value didn't have the expected type for the corresponding.

```
iex> OptionParser.parse(["--debug"], switches: [debug: :boolean])
{[debug: true], [], []}
iex> OptionParser.parse(["--source", "lib"], switches: [source: :string])
{[source: "lib"], [], []}
iex> OptionParser.parse(["--source-path", "lib", "test/enum_test.exs",
                   "--verbose"], 
                   switches: [source_path: :string, verbose: :boolean])
{[source_path: "lib", verbose: true], ["test/enum_test.exs"],[]}
```

Options
----

* :switches or :strict - see the "Switch definitions" section below
* :allow_nonexistent_atoms - see the "Parsing dynamic switches" section
* :aliases - see the "Alliases" section

Switch definitions
----
* :switches - defines some switches and their types. This function still attempts to parse switches that are not in this list
* :strict   - defines strict switches. Any switch in `argv` that is not specified in the list is returned in the invalid options list.

Types
----
Switches parsed by `OptionParser` may take zero or one arguments.

* :boolean - sets the value to `true`
* :count   - counts the number of times the switch is given
* :integer - 
* :float   -
* :string  -


