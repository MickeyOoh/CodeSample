GenStage
---


Consumers and Producers
---
As we've read, the role we gave our stage is important. The GenStage 
specification recognizes three roles:

* :producer -- A source. Producers wait for demand from consumers and 
  respond with the requested events.
* :producer_consumer -- Both a source and a sink. Producer-consumers can
  respond to demand from other consumers as well as request events from 
  producers
* :consumer -- A sink. A consumer requests and receives data from producers.

Notice that our producers wait for demand? With GenStage our consumers send
demand upstream and process the data from our producer. This facilitates a 
mechanism known as back-pressure. Back-pressure puts the onus on the
producer to not over-pressuer when consumers are busy.


Producer
---


The two most important pars to take note of here are `init/1` and `handle_demand/2`,
In `init/1` we set the initial state as we've done in our GenSerers, but
more importantly we label ourselves a a producer. The response from our
`init/1` function is what GenStage relies upon to calssify our process.

The `handle/demand/2` function is where the majority of our producer is 
defined. It must be imlemented by all GenStage producers. Here we return the
set of numbers demanded by our consumers and increment our counter. The 
demand from consumers, `demand` in our code above, is represented as an 
integer corresponding to the number of events they can handle; it defaults
to 1000.

