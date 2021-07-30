defmodule ThinNotionApi.Pages do
  import ThinNotionApi.Base

  @doc """
  Retrieves a Page object using the ID specified.

  Responses contains page properties, not page content. To fetch page content, use the retrieve block children endpoint.

  ## Examples:
      iex> ThinNotionApi.Pages.retrieve_page("9b4a624d5a18482ab2187e54166edda7")
      {:ok,
        %{
          "archived" => false,
          "created_time" => "2021-06-11T20:34:00.000Z",
          "id" => "9b4a624d-5a18-482a-b218-7e54166edda7",
          "last_edited_time" => "2021-07-30T21:03:00.000Z",
          "object" => "page",
          "parent" => %{"type" => "workspace", "workspace" => true},
          "properties" => %{
            "title" => %{
              "id" => "title",
              "title" => [
                %{
                  "annotations" => %{
                    "bold" => false,
                    "code" => false,
                    "color" => "default",
                    "italic" => false,
                    "strikethrough" => false,
                    "underline" => false
                  },
                  "href" => nil,
                  "plain_text" => "Thin Notion Test Workspace",
                  "text" => %{"content" => "Thin Notion Test Workspace", "link" => nil},
                  "type" => "text"
                }
              ],
              "type" => "title"
            }
          },
          "url" => "https://www.notion.so/Thin-Notion-Test-Workspace-9b4a624d5a18482ab2187e54166edda7"
        }
      }
  """
  @spec retrieve_page(String.t()) :: map()
  def retrieve_page(page_id) do
    get("pages/#{page_id}")
  end

  def create_page(parent_type, parent_id, properties \\ %{}, children \\ []) when parent_type == :page do
    body_params = %{}
    |> set_page_parent(parent_id)
    |> Map.put(:properties, properties)
    |> Map.put(:childern, children)

    post("pages", body_params)
  end

  defp set_page_parent(map, id) do
    Map.put(map, :parent, %{
      page_id: id
    })
  end
end
