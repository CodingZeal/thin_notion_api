defmodule ThinNotionApi.PagesTest do
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

  test "POST create_page of parent type database without title throws an error" do
    assert_raise RuntimeError, "You must have exactly one database property schema object of type 'title' in your properties.", fn ->
      Pages.create_page(:database, "9b4a624d5a18482ab2187e54166edda7")
    end
  end

  test "POST create_page of parent type database with non-valid parent_id" do
    use_cassette "post_create_page_type_page_error_parent_id" do
      {:error, response, 404} = Pages.create_page(:database, "9b4a624d5a18482ab2187e54166edda7", %{ "title": %{ "title": [%{ "type": "text", "text": %{ "content": "Create Page Database" } }] } })

      assert response["code"] == "object_not_found"
    end
  end

  test "POST create_page of parent type database" do
    use_cassette "post_create_page_type_database" do
      {:ok, response} = Pages.create_page(:database, "ee90be7f3fd14fd5961ef4203c7d9a81", %{ "title": %{ "title": [%{ "type": "text", "text": %{ "content": "Create Page Database" } }] } })
      assert Map.keys(response) == ["archived", "created_time", "id", "last_edited_time", "object", "parent", "properties", "url"]
      assert get_in(response, ["parent", "type"]) == "database_id"
      assert NotionTestHelpers.get_in_undasherized(response, ["parent", "database_id"]) == "ee90be7f3fd14fd5961ef4203c7d9a81"
    end
  end
end
