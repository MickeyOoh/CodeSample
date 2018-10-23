defmodule BasicShortnerTest do
  use ExUnit.Case
  #doctest BasicShortner

  setup do 
    {:ok, pid: Shortner.Basic.start_link}
  end
  
  test "shortening a url", %{pid: pid} do
    send(pid, {:shorten, self(), "apl", "http://apple.com"})
    assert_receive :ok
    send(pid, {:url, self(), "apl"})
    assert_receive {:ok, "http://apple.com"}
  end
  test "finding a url that does not exist", %{pid: pid} do 
    send(pid, {:url, self(), "something"})
    assert_receive :error
  end

end
