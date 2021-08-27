defmodule ThinNotionApi.Pages do
  @moduledoc """
  Module for interacting with the Notion pages.
  """
  import ThinNotionApi.Base
  alias ThinNotionApi.Properties

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

  @doc """
  Create a page with a page or database as its parent type.

  ## Examples:
      iex> ThinNotionApi.Pages.create_page(:page, "9b4a624d5a18482ab2187e54166edda7")
      {:ok,
      %{
        "archived" => false,
        "created_time" => "2021-08-20T20:16:00.000Z",
        "id" => "7418966f-ca3c-4f44-bf58-7e5f56f4fcd2",
        "last_edited_time" => "2021-08-20T20:16:00.000Z",
        "object" => "page",
        "parent" => %{
          "page_id" => "9b4a624d-5a18-482a-b218-7e54166edda7",
          "type" => "page_id"
        },
        "properties" => %{
          "title" => %{"id" => "title", "title" => [], "type" => "title"}
        },
        "url" => "https://www.notion.so/7418966fca3c4f44bf587e5f56f4fcd2"
      }}

      iex> ThinNotionApi.Pages.create_page(:database, "ee90be7f3fd14fd5961ef4203c7d9a81", %{ "title": %{ "title": [%{ "type": "text", "text": %{ "content": "Create Page Database" } }] } })
      {:ok,
        %{
          "archived" => false,
          "created_time" => "2021-08-13T21:50:00.000Z",
          "id" => "f96939de-e0a4-4175-a3ae-da8ee7512432",
          "last_edited_time" => "2021-08-13T21:50:00.000Z",
          "object" => "page",
          "parent" => %{
            "database_id" => "ee90be7f-3fd1-4fd5-961e-f4203c7d9a81",
            "type" => "database_id"
          },
          "properties" => %{
            "Name" => %{
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
                  "plain_text" => "Create Page Database",
                  "text" => %{"content" => "Create Page Database", "link" => nil},
                  "type" => "text"
                }
              ],
              "type" => "title"
            }
          },
          "url" => "https://www.notion.so/Create-Page-Database-f96939dee0a44175a3aeda8ee7512432"
        }
      }
  """
  def create_page(type, parent_id, properties \\ %{}, children \\ [])
  def create_page(:page, parent_id, properties, children) do
    body_params = %{}
    |> Properties.set_page_parent(parent_id)
    |> Map.put(:properties, properties)
    |> Map.put(:childern, children)

    post("pages", body_params)
  end

  def create_page(:database, parent_id, properties, children) do
    body_params = %{}
    |> Properties.set_database_parent(parent_id)
    |> Properties.set_database_properties(properties)
    |> Map.put(:childern, children)

    post("pages", body_params)
  end

  @doc """
  Update a pages properties or archive (delete) it.

  Properties that are not set via the properties parameter will remain unchanged.

  If the parent is a database, the new property values in the properties parameter must conform to the parent database's property schema.

  This endpoint is for updating page properties, not page content. To fetch page content, use the retrieve block children endpoint. To append page content, use the append block children endpoint.

  ## Examples:
      iex>  ThinNotionApi.Pages.update_page("c8445875c2cc424eb9eacba94cac667d", properties, false)
      {:ok,
      %{
        "archived" => false,
        "created_time" => "2021-08-20T20:26:00.000Z",
        "id" => "c8445875-c2cc-424e-b9ea-cba94cac667d",
        "last_edited_time" => "2021-08-20T21:07:00.000Z",
        "object" => "page",
        "parent" => %{
          "page_id" => "9b4a624d-5a18-482a-b218-7e54166edda7",
          "type" => "page_id"
        },
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
                "plain_text" => "Test: Used for updating page test",
                "text" => %{
                  "content" => "Test: Used for updating page test",
                  "link" => nil
                },
                "type" => "text"
              }
            ],
            "type" => "title"
          }
        },
        "url" => "https://www.notion.so/Test-Used-for-updating-page-test-c8445875c2cc424eb9eacba94cac667d"
      }}
  """
  @spec update_page(String.t(), map(), boolean()) :: map()
  def update_page(page_id, properties \\ %{}, archived \\ false) do

    body_params = %{}
    |> Map.put(:properties, properties)
    |> Map.put(:archived, archived)

    patch("pages/#{page_id}", body_params)
  end
end
