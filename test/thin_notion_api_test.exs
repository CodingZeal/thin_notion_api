defmodule ThinNotionApiTest do
  use ExUnit.Case
  doctest ThinNotionApi

  test "greets the world" do
    assert ThinNotionApi.hello() == :world
  end
end
