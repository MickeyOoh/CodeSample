f =
  fn x ->
    case x do 
      1 ->
        defmodule M do 
          def say do
            "one"
          end
        end
      2 ->
        defmodule N do
          def say do
            "two"
          end
        end
    end
  end

#M.say
#N.say
f.(1)
IO.puts M.say
#N.say
f.(2)
IO.puts N.say
