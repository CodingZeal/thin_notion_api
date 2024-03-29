defmodule ThinNotionApi.BlocksTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ThinNotionApi.Blocks

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

  test "GET retrieve_block_children" do
    use_cassette "get_retrieve_block_children" do
      {:ok, response} = Blocks.retrieve_block_children("9b4a624d5a18482ab2187e54166edda7")
      assert get_in(response, ["object"]) == "list"
      assert get_in(response, ["results"]) |> List.first() |> get_in(["object"]) == "block"
      assert get_in(response, ["results"]) |> List.first() |> get_in(["type"]) == "paragraph"
      assert get_in(response, ["results"])
      |> List.first()
      |> get_in(["paragraph", "text"])
      |> List.first()
      |> get_in(["plain_text"]) == "Hello world!"
    end
  end

  test "PATCH update_block" do
    use_cassette "patch_update_block", match_requests_on: [:request_body] do
      {:ok, response} = Blocks.update_block("c4c027f4ea7c41c5908d63a7f5a9c32c", %{
        paragraph: %{
          text: [%{
            type: "text",
            text: %{
              content: "Hello DOGE!",
            }
          }],
        }
      })
      assert get_in(response, ["paragraph", "text"])
      |> List.first()
      |> get_in(["plain_text"]) == "Hello DOGE!"

      {:ok, response} = Blocks.update_block("c4c027f4ea7c41c5908d63a7f5a9c32c", %{
        paragraph: %{
          text: [%{
            type: "text",
            text: %{
              content: "Hello world!",
            }
          }],
        }
      })

      assert get_in(response, ["paragraph", "text"])
      |> List.first()
      |> get_in(["plain_text"]) == "Hello world!"
    end
  end

  test "PATCH append_block_children" do
    use_cassette "patch_append_block_children", match_requests_on: [:request_body] do
      children = [%{
        object: "block",
        type: "paragraph",
        paragraph: %{
          text: [%{
            type: "text",
            text: %{
              content: "Testing for append_block_children",
            }
          }]
        }
      }]

      {:ok, _response} = Blocks.append_block_children("9b4a624d5a18482ab2187e54166edda7", children)

      # API right now isnt returning the children, so we have to do this
      {:ok, response} = Blocks.retrieve_block_children("9b4a624d5a18482ab2187e54166edda7")
      assert get_in(response, ["object"]) == "list"
      assert get_in(response, ["results"])
      |> List.last()
      |> get_in(["paragraph", "text"])
      |> List.first()
      |> get_in(["plain_text"]) == "Testing for append_block_children"
    end
  end

  test "DELETE block" do
    use_cassette "delete_block", match_requests_on: [:request_body] do
      {:ok, response} = Blocks.retrieve_block_children("9b4a624d5a18482ab2187e54166edda7")
      block = get_in(response, ["results"]) |> List.last()

      assert block |> get_in(["paragraph", "text"]) |> List.first() |> get_in(["plain_text"]) == "Testing for append_block_children"

      {:ok, response} = Blocks.delete_block(get_in(block, ["id"]))
      assert get_in(response, ["archived"]) == true
    end
  end
end
