
for x <- 0..10, do: IO.puts x

defmodule ForLoop do 
  def for_loop(count, action) 
  when is_integer(count) and is_function(action) do
    loop(action, count, 0)
  end
  
  defp loop(_action, count, acc) when acc > count, do: :ok
  defp loop(action, count, acc) when acc <= count do 
    action.(acc)
    loop(action, count, acc+1)
  end
end

# 3.
Enum.each(0..10, &(IO.puts(&1)))

# 4.
defmodule While do 
  @doc """
  Loops `body` until a value is thrown using `throw/1`
  Passed to `body` is the `starting_value` (which defaults to `nil`)
  in the first iteration in the next iterations, the result of the 
  previous iteration is used as passed parameter.
  """
  def loop(body, starting_value \\ nil) when is_function(body) do 
    try do 
      iteration_result = body.(starting_value)
      loop(body, iteration_result)
    catch
      thrown_result -> thrown_result
    end
  end
  def random_example do 
    result = loop fn ->
      x = :rand.normal
      IO.inspect x
      if x > 1, do: throw x
    end
    IO.puts "Result: #{result}"
  end
  def counter_example do 
    loop(fn x ->
      if x > 100, do: throw "DONE"
      IO.puts x
      x + 1
    end, 0)
  end
end

defmodule MyList do 
  def flatten([]), do: []
  def flatten([head | tail]) do 
    flatten(head) ++ flatten(tail)
  end

  def flatten(head), do: [head]
end

IO.inspect MyList.flatten( [ [1], [2,[3]], [4]])
IO.inspect MyList.flatten([ [], [ [], [3] ], [4]])



