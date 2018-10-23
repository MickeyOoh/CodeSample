lazy
----
* Folds computations, goes item by item
* Less memory usage at the cost of computation
* Allows us to work with large or infinite collections


Concurrent
----

```
File.stream!("source", [], :line)
|> 
```

Flow
----
* We give up ordering and process locality for concurrency
* Tools for working with bounded and unbounded data
* It is not magic! There is an overhead when data flows through procsses
* Requires volume and/or cpu/io-bound work to se benefits

Flow stats
---
* ~1200 lines of code(LOC)
* ~1300 lines of documentation(LOD)

topics
1299LOC: how is flow implementd?
1300LOD: 

Genstage
----

