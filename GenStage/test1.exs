File.read!("source.txt")
|> String.split("\n",trim: true)
|> IO.inspect
|> Enum.flat_map(&String.split/1)
|> IO.inspect
|> Enum.reduce(%{}, fn word, map ->
      Map.update(map, word, 1, &(&1 + 1)) end)
|> IO.inspect
