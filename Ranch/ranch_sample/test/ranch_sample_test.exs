defmodule RanchSampleTest do
  use ExUnit.Case
  doctest RanchSample

  test "greets the world" do
    assert RanchSample.hello() == :world
  end
end
