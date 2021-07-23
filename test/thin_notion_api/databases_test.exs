defmodule ThinNotionApi.DatabasesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ThinNotionApi.Databases

  setup_all do
    HTTPoison.start
  end

  test "GET retrieve_database" do
    use_cassette "get_retrieve_database" do
      {:ok, response} = Databases.retrieve_database("a4ef92b2a7984bae82114817678cd2f4")
      assert Map.get(response, "id") == "a4ef92b2-a798-4bae-8211-4817678cd2f4"
      assert Map.keys(response) == ["created_time", "id", "last_edited_time", "object", "parent", "properties", "title"]
    end
  end
end
