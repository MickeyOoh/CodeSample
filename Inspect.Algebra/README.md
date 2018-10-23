Inspect.Algebra
----
A set of functions for creating and manipulating algebra documents.

This module implements the functionality described in [Strictly Pretty](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.34.2200)
with small additions, like support for binary nodes and a break mdoe that
maximises use of horizontal space.


```
iex> Inspect.Algebra.empty
:doc_nil
iex> "foo"
"foo"
iex> doc = Inspect.Algebra.concat(Inspect.Algebra.empty, "foo") 
{:doc_cons, :doc_nil, "foo"}
iex> Inspect.Algebra.format(doc, 80)
["foo"]
```

The function `nest/2`, `space/2` and `line/2` help you put the document
together into a rigitd structure. However, the document algebra gets
interesting when using functions like `glue/2` and `group/1`. A glue inserts
a break between two documents. A group indicates a document that must fit
the current line, otherwise breaks are rendered as new lines. Let's glue
two docs together with a break, group it and then render it:

```
iex> doc= Inspect.Algebra.glue("a", " ", "b")
{:doc_cons, "a", {:doc_cons, {:doc_break, " ", :strict}, "b"}}
iex> doc = Inspect.Algebra.group(doc)
{:doc_group, {:doc_cons, "a", {:doc_cons, {:doc_break, " ", :strict}, "b"}},
 :self}
iex(6)> Inspect.Algebra.format(doc,80)
["a", " ", "b"]
```
Notice the break was represented as is, because we haven't reached a line
limit. Once we do, it is  replaced by a newline.
```
iex> doc = Inspect.Algebra.glue(String.duplicate("a", 20), " ", "b")
{:doc_cons, "aaaaaaaaaaaaaaaaaaaa",
 {:doc_cons, {:doc_break, " ", :strict}, "b"}}
iex> doc = Inspect.Algebra.group(doc)
{:doc_group,
 {:doc_cons, "aaaaaaaaaaaaaaaaaaaa",
  {:doc_cons, {:doc_break, " ", :strict}, "b"}}, :self}
iex> Inspect.Algebra.format(doc, 10)
["aaaaaaaaaaaaaaaaaaaa", "\n", "b"]
```


