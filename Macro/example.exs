defmodule MySigils do 
  defmacro sigil_x(term, [?r]) do 
    quote do
      unquote(term) |> String.reverse()
    end
  end
  defmacro sigil_x(term, _modifiers) do 
    term
  end
  defmacro sigil_X(term, [?r]) do 
    quote do 
      unquote(term) |> String.reverse()
    end
  end
  defmacro sigil_X(term, _modifiers) do 
    term
  end
end

defmodule Test do 

  import MySigils

  str = ~x(with #{"inter" <> "polation"})
  IO.puts str
  
  str = ~x(with #{"inter" <> "polation"})r
  IO.puts str

  str = ~X(without #{"interpolation"})
  IO.puts str

  str = ~X(without #{"interpolation"})r
  IO.puts str

end
