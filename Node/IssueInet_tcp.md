Issue: Protocol 'inet_tcp': register/listen error: econnrefused 
----
The error "Protocol 'inet_tcp': register/listen error: econnrefused" means 
that the Erlang node tried to connect to epmd 
(the Erlang port mapper daemon) to register its name, but failed to connect.

That shouldn't happen: epmd should be started when the Erlang node starts
up. You could try running epmd manually in the shell, and see if it
reports any errors.



