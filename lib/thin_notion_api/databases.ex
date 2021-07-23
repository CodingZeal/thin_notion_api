defmodule ThinNotionApi.Databases do
  @moduledoc """
  Module for interacting with the Notion Databases.
  """

  import ThinNotionApi.Base

  @doc """
  Retrieves a Database object using the ID specified.

  ## Examples

      iex> ThinNotionApi.Databases.retrieve_database(database_id)
      {:ok,
      %{
        "created_time" => "2021-06-11T20:34:00.000Z",
        "id" => "a4ef92b2-a798-4bae-8211-4817678cd2f4",
        "last_edited_time" => "2021-07-16T20:44:00.000Z",
        "object" => "database",
        "parent" => %{
          "page_id" => "9b4a624d-5a18-482a-b218-7e54166edda7",
          "type" => "page_id"
        },
        "properties" => %{
          "Name" => %{"id" => "title", "title" => %{}, "type" => "title"},
          "Tags" => %{
            "id" => "@Tnd",
            "multi_select" => %{"options" => []},
            "type" => "multi_select"
          }
        },
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
            "plain_text" => "Test Database",
            "text" => %{"content" => "Test Database", "link" => nil},
            "type" => "text"
          }
        ]
      }}
  """
  def retrieve_database(database_id) do
    get("databases/" <> database_id)
  end

  @doc """
  List all Databases shared with the authenticated integration. The response may contain fewer than page_size of results.

  > Use search pages for more details.

  > This endpoint is no longer recommended, use search instead. This endpoint will only return explicitly shared pages, while search will also return child pages within explicitly shared pages. This endpoint's results cannot be filtered, while search can be used to match on page title.

  ## Examples:
      iex> ThinNotionApi.Databases.list_databases(query_params)

  """
  def list_databases(query_params \\ %{}) do
    get("databases", query_params)
  end

  @doc """
  Gets a list of Pages contained in the database, filtered and ordered according to the filter conditions and sort criteria provided in the request. The response may contain fewer than page_size of results.

  ## Examples:
      iex> ThinNotionApi.Databases.query_database(database_id)
      {:ok,
        %{
          "has_more" => false,
          "next_cursor" => nil,
          "object" => "list",
          "results" => [
            %{
              "archived" => false,
              "created_time" => "2021-06-11T20:34:00.000Z",
              "id" => "0a8f7171-00b7-4f7e-a0b5-155f006186bb",
              "last_edited_time" => "2021-07-16T21:04:00.000Z",
              "object" => "page",
              "parent" => %{
                "database_id" => "a4ef92b2-a798-4bae-8211-4817678cd2f4",
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
                      "plain_text" => "Hello World",
                      "text" => %{"content" => "Hello World", "link" => nil},
                      "type" => "text"
                    }
                  ],
                  "type" => "title"
                }
              },
              "url" => "https://www.notion.so/Hello-World-0a8f717100b74f7ea0b5155f006186bb"
            },
            ...
          ]
        }
      }

      iex> ThinNotionApi.Databases.query_database("a4ef92b2a7984bae82114817678cd2f4", %{ "page_size" => 1})
      {:ok,
        %{
          "has_more" => true,
          "next_cursor" => "700b4e34-697c-4fad-b97d-d9741d1fbaeb",
          "object" => "list",
          "results" => [
            %{
              "archived" => false,
              "created_time" => "2021-06-11T20:34:00.000Z",
              "id" => "0a8f7171-00b7-4f7e-a0b5-155f006186bb",
              "last_edited_time" => "2021-07-16T21:04:00.000Z",
              "object" => "page",
              "parent" => %{
                "database_id" => "a4ef92b2-a798-4bae-8211-4817678cd2f4",
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
                      "plain_text" => "Hello World",
                      "text" => %{"content" => "Hello World", "link" => nil},
                      "type" => "text"
                    }
                  ],
                  "type" => "title"
                }
              },
              "url" => "https://www.notion.so/Hello-World-0a8f717100b74f7ea0b5155f006186bb"
            }
          ]
        }}
  """
  def query_database(database_id, body_params \\ %{}) do
    post("databases/" <> database_id <> "/query", body_params)
  end

  @spec create_database!(String.to_atom(), String.t(), map()) :: any
  def create_database!(parent_id, title, properties \\ %{
    Name: %{
      title: %{}
    },
  }) do
    body_params = %{}
    |> set_parent(parent_id)
    |> set_title(title)
    |> set_properties(properties)

    post("databases", body_params)
  end

  defp set_parent(map, parent_id) do
    Map.put(map, :parent, %{
      type: "page_id",
      page_id: parent_id
    })
  end

  defp set_title(map, title) do
    Map.put(map, :title, [%{
      type: "text",
      text: %{
          content: title,
          link: nil
      }
    }])
  end

  defp set_properties(map, properties) do
    case Map.values(properties) |> Enum.any?(fn (value) -> Map.has_key?(value, :title) end) do
      true ->
        Map.put(map, :properties, properties)
      _ ->
        raise "You must have exactly one database property schema object of type 'title' in your properties."
    end
  end
end
