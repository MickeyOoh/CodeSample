Transfer data through Nodes
----

device 1

```
$ iex --name mac1@192.168.2.202 --cookie abc

iex(mac1)> Node.connect(:"mac2@192.168.2.246")
true
iex(mac1)> fpid = File.open!("test.txt", [;write, :utf8]

iex(mac1)> mac2pid = :global.whereis_name(:mac2pid
iex(mac1)> send mac2pid, fpid

iex(mac1)> File.read "test.txt"
{:ok, "hello World"}

```

Mac2
```
$ iex --name mac2@192.168.2.246 --cookie abc

iex(mac2)> :global.regsiter_name(:mac2pid, self())

iex(mac2)> f = receive do 
...      >    f -> f
...      > end
iex(mac2)>
iex(mac2)> IO.write f, "hello World"
iex(mac2)> File.close f

```
