Port
---
Functions for interactiving with external world through ports.

Ports provide a nechanism to start operating system processes external to
the Erlang VM and communicate with them via message passing.

Example
```
iex(1)> port = Port.open({:spawn, "cat"}, [:binary])
#Port<0.5>
iex(2)> send(port, {self(), {:command, "hello"}})
{#PID<0.100.0>, {:command, "hello"}}
iex(3)> send(port, {self(), {:command, "world"}})
{#PID<0.100.0>, {:command, "world"}}
iex(4)> flush()
{#Port<0.5>, {:data, "hello"}}
{#Port<0.5>, {:data, "world"}}
:ok
iex(5)> send(port, {self(), :close})
{#PID<0.100.0>, :close}
iex(6)> flush()
{#Port<0.5>, :closed}
:ok
```
IN the example above, we have created a new port that executes the program
`cat`. `cat` is a program avaliable on UNIX systems that receives data from
multiple inputs and concatenates them in the output.
After the port was created, we sent it two commands in the form of messages
using `Kernel.send/2`. The first command has the binary payload of "hello"
and the second has "world".
After sending those two messages, we involved the IEx helper `flush()`, 
which printed all messages received from the port, in this case we got
"hello" and "world" back, Notice the messages are in binary because we
passed the `:binary` option when opening the port in `Port.open/2`. 
Without such option, it would have yielded a list of bytes.

Once everything was done, we closed the port.
Elixir provdies many conveniences for working with ports and some drawbacks.
We will explore those below.

Message and function APIs
----
There are **two APIs** for working with ports. It can be either asynchronous
via message passing, as in the example above, or by calling the functions on
this module.

The messages supported by ports and their counterpart function APIs are
listed below:
* {pid, {:command, binary}} -sends the given data to the port.See `command/3`
* {pid, :close} - closes the port.Unless the port is already closed, the
   port will reply with `{port, :closed}` message once it has flushed its
   buffers and effectively closed. See `close/1`.
* {pid, {:connect, new_pid} - sets the `new_pid` as the new owner of the
  port. Once a port is opened, the port is linked and connected to the
  caller process and communication to the port only happens through the 
  connected process. This message makes `new_pid` the new connected
  processes. Unless the port is dead, the port will reply to the old owner
  with `{port, :connected}`. See `connect/2`.

On its turn, the port will send the connected process the following messages:
* {port, {:data, data}} - data sent by the port
* {port, :closed} - reply to the `{pid, :close}` message
* {port, :connected} - reply to the `{pid, {:connect, new_pid}}` message
* {:EXIT, port, reason} - exit signals in case the port crashes. If reason
   is not `:normal`, this message will only be received if the owner process
   is trapping exits.

Open mechanisms
-----
The port can be opened through four main mechanisms.


### spawn
---

### spawn_executable
---

### fd
----
The `:fd` name option allows developers to access `in` and `out` file 
descriptors used by the Erlang VM. You would use those only if you are
reimplementing core part of the Runtime System, such as the `:user` and
`:shell` processes.

Zombie OS processes
-----

