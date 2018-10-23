This section outlines an example of how to solve the eample problem in 
*Problem Example* by using **Native Implemented Fucntions(NIFs)**.

It is a simpler and more efficient way of calling C-code than using port drivers.
NIFs are most suitable for synchronous functions, such as foo and bar in the
example, that do some relatively short calculations without side effects
and return the result.

A NIF is a function that is implemented in C instead of Erlang. NIFs appear
as any other functions to the callers. they belong to a module and are 
called like any other Erlang functions. The NIFs of a moudle are compiled
and linked into a dynammic loadable, shared library(SO in UNIX, DLL in Windows).
The NIF library must be loaded in runtime by the Erlang code of the module.

As a NIF library is dynamically linked into the emulator process, this is
the fastest way of calling C-code from Erlang(alongside port drivers). 
Calling NIFs requires no context switches. But it is also the least safe, 
because a crash in a NIF brings the emulator down too.

8.1 Erlang Program
----


