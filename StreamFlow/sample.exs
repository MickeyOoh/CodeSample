
File.stream!("path/to/file", [], :line)
|> Flow.from_enumerable()
|> Flow.flat_map(&String.split/1)

