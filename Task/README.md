Task
----
conveniences for spawning and awaiting tasks.

Tasks are processes meant to execute one particular action throughout their
lifetime, often with little or no communication with other processes. The
most common use case for tasks is to convert sequential code into concurrent
code by computing a value asynchronously:

```
task = Task.async(fn -> do_some_work() end)
res = do_some_other_work()
res + Task.await(task)
```
Tasks spawned with `async` can be awaited on by their caller process(and
only their caller) as shown in the example above. They are implemented by 
spawning a process that sends a message to the caller once the given 
computation is performed.

Besides `async/1` and `await/2`, tasks can be started as part of a 
supervision tree and dynamically spawned on remote nodes. We will
explore all three scenarios next.

my own expriment
```
iex> task = Task.async(fn -> IO.puts "starts"; {:ok, "starts"} end)
starts
%Task{
  owner: #PID<0.100.0>,
  pid: #PID<0.102.0>,
  ref: #Reference<0.3360258028.2999451649.100890>
}
iex> Task.await(task)
{:ok, "starts"}
```
So the process was executed by calling `async` and `await` gets the result.

async and await
----
One of the common uses of tasks is to convert sequential code into 
concurrent code with `Task.async/1` while keeping its semantics. When
invoked, a new process will be created, linked and monitored by the caller.
Once the task action finishes, a message will be sent to the caller with the
result.

`Task.await/2` is used to read the message sent by the task.

There are two important things to consider when using `async`:
1. If you are using async tasks, you must await a reply as they are always
   sent. If you are not expecting a reply, consider usingi `Task.start_link/1`
   detailed below.
2. async tasks link the caller and the spawned process. This means that, if 
   the caller crashes, the task will crash too and vice-versa. This is on 
   purpose: if the process meant to receive the result no longer exists, 
   there is no purpose in completing the computation.



