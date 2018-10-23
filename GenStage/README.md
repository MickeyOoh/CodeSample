GenStage
----
* it is a new behaviour
* Exchanges data between stages transparently with back-pressure
* Braks into producers, consumers and producer_consumers


GenStage behavior
----

Stages are data-exchange steps that send and/or receive data from
other stages.
When a stage sends data, it acts as a **producer**. When it receives data, it acts as a **consumer**. Stages may take both producer and consumer roles at once.

Stage types
-----
a stage may be called **source** if it only produces items
or called **sink** if it only consumes items.

[**A]** -> [**B]** -> [**C]**

- A is only a producer(and therefore a source)
- B is both
- C is only a consumer(and therefore a sink)

To start the flow of events, we subscribe consumers to producers.
Once the communication channel between them is established, consumers will
ask the producers for events. We typically say the consumer is sending
demand upstream. Once demand arrives, the producer will emit items, never
emitting more items than the consumer asked for. This provides a 
back-pressure mechanism.

A consumer may have multiple producers and a producer may have multiple
consumers. When a consumer asks for data, each producer is handled
separately, with its own demand. When a producer receives demand and sends
data to multiple consumers, the demand is tracked and the events are sent
by a dispatcher. This allows producers to send data using different 
"startegies". See `GenStage.Dispatcher` for more information.




Example
----
Where A is a producer that will emit items starting from 0, 
B is a producer-consumer that will receive those items and multiply
them by a given number
and C will receive those events and print them to the terminal.

Since A is a producer, its main responsibility is to receive demand and generate events. Those events may be in memory or an external 
queue system. For simpolicity, let's implement a simple counter starting from a given value of *counter* received on `init/1`:

