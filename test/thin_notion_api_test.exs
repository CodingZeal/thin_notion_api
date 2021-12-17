defmodule ThinNotionApiTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  test "POST search" do
    use_cassette "post_search" do
      {:ok, response} = ThinNotionApi.search(%ThinNotionApi.Types.SearchParams{
        query: "Thin Notion Test Workspace",
      })

      assert get_in(response, ["results"]) |> List.first() |> get_in(["id"]) == "9b4a624d-5a18-482a-b218-7e54166edda7"
    end
  end
end
