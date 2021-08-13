defmodule ThinNotionApi.PahesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ThinNotionApi.Pages
  alias ThinNotionApi.NotionTestHelpers

  setup_all do
    HTTPoison.start
  end

  test "GET retrieve_pages" do
    use_cassette "get_retrieve_pages" do
      {:ok, response} = Pages.retrieve_page("9b4a624d5a18482ab2187e54166edda7")
      assert Map.get(response, "id") |> String.replace("-", "") == "9b4a624d5a18482ab2187e54166edda7"
      assert Map.keys(response) == ["archived", "created_time", "id", "last_edited_time", "object", "parent", "properties", "url"]
      assert get_in(response, ["properties", "title", "title"]) |> Enum.at(0) |> get_in(["plain_text"]) == "Thin Notion Test Workspace"
    end
  end

  test "POST create_page of parent type page" do
    use_cassette "post_create_page_type_page" do
      {:ok, response} = Pages.create_page(:page, "9b4a624d5a18482ab2187e54166edda7")
      assert Map.keys(response) == ["archived", "created_time", "id", "last_edited_time", "object", "parent", "properties", "url"]
      assert get_in(response, ["parent", "type"]) == "page_id"
      assert NotionTestHelpers.get_in_undasherized(response, ["parent", "page_id"]) == "9b4a624d5a18482ab2187e54166edda7"
      assert get_in(response, ["properties", "title", "title"]) |> Enum.count == 0
    end
  end

  test "POST create_page of parent type database" do
    use_cassette "post_create_page_type_database" do
      {:ok, response} = Pages.create_page(:database, "9b4a624d5a18482ab2187e54166edda7")
      assert Map.keys(response) == ["archived", "created_time", "id", "last_edited_time", "object", "parent", "properties", "url"]
      assert get_in(response, ["parent", "type"]) == "database_id"
      assert NotionTestHelpers.get_in_undasherized(response, ["parent", "database_id"]) == "9b4a624d5a18482ab2187e54166edda7"
      assert get_in(response, ["properties", "title", "title"]) |> Enum.count == 0
    end
  end
end
