defmodule ThinNotionApi.BlocksTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ThinNotionApi.Blocks
  alias ThinNotionApi.NotionTestHelpers

  setup_all do
    HTTPoison.start
  end

  test "GET retrieve_block" do
    use_cassette "get_retrieve_block" do
      {:ok, response} = Blocks.retrieve_block("9b4a624d5a18482ab2187e54166edda7")
      assert get_in(response, ["type"]) == "child_page"
      assert get_in(response, ["child_page", "title"]) == "Thin Notion Test Workspace"
    end
  end
end
