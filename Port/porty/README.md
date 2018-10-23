Communicating with C from Elixir using Ports
----
On occasion your Elixir is going to want to interact with an external
program. This may be for speed, but more likely you are going to want to 
take advantage of a library that has been written in C. The most common
options are using **Ports** and **Native Interface Functions(NIFs)**.



Step1 - Create our Mix project with some C inside
----
```
mix new porty --sup
```
**elixir_make** simplifies compiling from a Makefile as part your Elixir
compilation, so let's include that our `mix.exs deps` and them run `mix deps.get`.
```
defp deps do 
  [
    {:elixir_make, "~> 0.4"},
  ]
end
```
And we are going to want to include `elixir_make` as a project compiler with
the line `compilers: [:elixir_make | Mix.compilers]`,:
```
def project do 
  [
    app: :porty,
    version: "0.1.0",
    elixir: "~> 1.6",
    start_permanent: Mix.env == :prod,
    compilers: [:elixir_make | Mix.compilers],
    deps: deps()
  ]
end
```
Next we will need a `Makefile` in the project root.

```
CFLAGS= -g

HEADER_FILES = src

SRC =$(wildcard src/*.c)

OBJ = $(SRC:.c=.o)

DEFAULT_TARGETS ?= c_priv priv/c/echo

priv/c/echo: c_priv $(OBJ)
  $(CC) -I $(HEADER_FILES) -o $@ $(LDFLAGS) $(OBJ) $(LDLIBS)

c_priv:
  mkdir -p priv/c

clean: 
  rm -f priv/c $(OBJ) $(BEAM_FILES)
```
This will compile C files in the directory `src/` and create an executable
in the directory `priv/c`. So, we'd better give it something to compile
`src/echo.c`
```
#include<stdio.h>

int main(int argc, char *argv[]) {
  printf("Hello you fake Port program.\n");
  return 1;
}
```
Now it we run `mix compile` we should get an executable `priv/c/echo`.
Calling `./priv/c/echo` will print out our "hello" message.

Step2 - Write the C program
----

### Reading from STDIN
----
We have our executable, but it is not suitable for communicating over erlang
ports, which use STDIN and STDOUT for communication with the Erlang VM.
Let's write a C function for reading a fixed number of bytes from STDIN.

[read_fixed(char *buffer, int len)](src/echo.c)

Bytes are read from stdin up to len characters using the UNIX read function
into the buffer. The code is a little more compilcated than otherwise, as we
are handling the case of a read being interrupted by a signal. Checking for
0 being returned from read is very important, otherwise when you close the
port(or the Erlang VM node) the read loop will become infinite, turning the
process into a CPU-eating zombie.

To round it all off, here's a function to read a fixed length message from
STDIN and zero-terminate the buffer.

[read_in(char *buffer, int len)](src/echo.c)

We can now read data for a certain length from STDIN, but how do we know 
what length that is? We will configure our `port` such that the first two
bytes tell us the length of the remaining. Here is a function for reading
those first two bytes adn returning that length. Note that the most 
significant byte is the first.

[to_read_length()](src/echo.c)

As Columbo might say, just one more thing: how do we know that we have
something useful to read? We will make use of `poll`:

[poll_input()](src/echo.c)

`poll` above will block for 5 seconds for data to become available, 
specified by the `POLLIN` flag. It will return 1(POLLIN) if data is
available, or 0 in case of timeout.

Now we should be able to read messages from our Elixir program, and do 
something with them. For now let's just print them to `STDERR`.(Printing
to `STDERR` is helpful for development and debugging; like `IO.inspect`, we
will remove these from the final version.)

[main()](src/echo.c)

Above we are looping constantly, reading from STDIN and echoing the result
out to STDERR, if anything is available. (Note that I've left out forward
references and includes; if you are conding along then grab them from here).

Let's give it a spin

```
iex -S mix

iex> port = Port.open({:spawn, :code.priv_dir(:porty) ++ '/c/echo'},
...>             [{:package, 2}])
#Port<0.xx>
iex> Port.command(port, "hello matey")
hello matey
true
iex> Port.close(port)

```
Note a couple of things: 
> We set the packet size to 2 above. This is how we configure the port to
> prepend the length of the mssage using two bytes at the beginning.
> We find the executable with :code.priv_dir(:porty) ++ '/c/echo'. This
> will allow us to find it even when we are pakaged for a release.

Writing back to Elixir through STDOUT
----

