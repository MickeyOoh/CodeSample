defmodule Test do 
  def test1 do 
    opts = %{width: 10, height: 15}
    with {:ok, width} <- Map.fetch(opts, :width),
         {:ok, height} <- Map.fetch(opts, :height)
    do 
      {:ok, width * height}
    end
  end
end

IO.puts File.read!("fn_with.exs")
IO.inspect Test.test1

