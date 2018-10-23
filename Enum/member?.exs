# member?(enumberable, element)

IO.puts "Enum.member?(1..10, 5)->#{Enum.member?(1..10, 5)}"

IO.puts "Enum.member?(1..10, 5.0)->#{Enum.member?(1..10, 5.0)}"

IO.puts "Enum.member?([1.0,2.0,3.0], 2)->#{Enum.member?([1.0,2.0,3.0], 2)}"

IO.puts "Enum.member?([:a, :b, :c], :d)->#{Enum.member?([:a, :b, :c], :d)}"
