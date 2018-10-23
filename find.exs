defmodule Find do 
  @moduledoc """
  Implements methods to find elements in given collections by pattern matching.
  """

  @doc """
  Finds the first element in a list to match a given pattern,.
  """
  def first_match(collection) do 
    Enum.find(collection, fn(element) ->
      match?({:fruit, _}, element)
    end)

  end

  @doc """
  Finds all the elements in a list that match a given pattern.
  """
  def all_matches(collection) do 
    Enum.filter(collection, fn(element) ->
      match?({:fruit, _}, element)
    end)
  end
end

defmodule Test do 

end
