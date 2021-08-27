defmodule ThinNotionApi.DatabasesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ThinNotionApi.Databases
  alias ThinNotionApi.NotionTestHelpers

  setup_all do
    HTTPoison.start
  end

  test "GET retrieve_database" do
    use_cassette "get_retrieve_database" do
      {:ok, response} = Databases.retrieve_database("a4ef92b2a7984bae82114817678cd2f4")
      assert NotionTestHelpers.get_in_undasherized(response, ["id"]) == "a4ef92b2a7984bae82114817678cd2f4"
      assert Map.keys(response) == ["created_time", "id", "last_edited_time", "object", "parent", "properties", "title"]
    end
  end

  test "GET list_databases" do
    use_cassette "get_list_databases" do
      {:ok, response} = Databases.list_databases()
      assert Map.get(response, "object") == "list"
      assert Map.keys(response) == ["has_more", "next_cursor", "object", "results"]
    end
  end

  test "POST query_database without params" do
    use_cassette "post_query_database_no_params" do
      {:ok, response} = Databases.query_database("a4ef92b2a7984bae82114817678cd2f4")
      assert Map.get(response, "object") == "list"
      assert Map.keys(response) == ["has_more", "next_cursor", "object", "results"]
      assert Enum.count(Map.get(response, "results")) == 3
    end
  end

  test "POST query_database with params" do
    use_cassette "post_query_database_with_params" do
      {:ok, response} = Databases.query_database("a4ef92b2a7984bae82114817678cd2f4", %{"page_size" => 1})
      assert Map.get(response, "object") == "list"
      assert Map.keys(response) == ["has_more", "next_cursor", "object", "results"]
      assert Enum.count(Map.get(response, "results")) == 1
    end
  end

  test "POST create_database!" do
    use_cassette "post_create_database" do
      {:ok, response} = Databases.create_database!("9b4a624d5a18482ab2187e54166edda7", "New Database")
      assert Map.keys(response) == ["created_time", "id", "last_edited_time", "object", "parent", "properties", "title"]
      assert NotionTestHelpers.get_in_undasherized(response, ["parent", "page_id"]) == "9b4a624d5a18482ab2187e54166edda7"
      assert get_in(response, ["title"]) |> Enum.at(0) |> get_in(["plain_text"]) == "New Database"
    end
  end
end
