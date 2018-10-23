RAnch
----
Ranch is a  socket acceptor pool for tCP protocols.

Goals
----
Ranch aims to provide everything you need to accept TCP connections with
a small code base and low latency while being easy to use directly as an 
application or to embed into your own.

Ranch provides a modular design, letting you choose which transport and 
protocol are going to be used for a particular listener. Listeners
accept and manage connections on one port, and include facilites to limit
the number of concurrent connections. Connections are sorted into pools, 
each pool, each pool having a different configurable limit.


