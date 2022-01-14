defmodule ThinNotionApi.Databases do
  @moduledoc """
  Module for interacting with the Notion Databases.
  """

  import ThinNotionApi.Base
  alias ThinNotionApi.{Properties, Types}

  @spec retrieve_database(String.t()) :: Types.Response.t()
  @doc """
  Retrieves a Database object using the ID specified.

  ## Examples

      iex> ThinNotionApi.Databases.retrieve_database(database_id)
      {:ok, %{...}}
  """
  def retrieve_database(database_id) do
    get("databases/" <> database_id)
  end

  @spec query_database(String.t(), Types.DatabaseQueryParams.t() | %{}) :: Types.Response.t()
  @doc """
  Gets a list of Pages contained in the database, filtered and ordered according to the filter conditions and sort criteria provided in the request. The response may contain fewer than page_size of results.

  ## Examples:

      iex> ThinNotionApi.Databases.query_database(database_id)
      {:ok, %{...}}

      iex> ThinNotionApi.Databases.query_database("a4ef92b2a7984bae82114817678cd2f4", %{ "page_size" => 1})
      {:ok, %{...}}
  """
  def query_database(database_id, body_params \\ %{}) do
    post("databases/" <> database_id <> "/query", body_params)
  end

  @doc """
  Gets a list of Pages contained in the database, filtered and ordered according to the filter conditions and sort criteria provided in the request. The response may contain fewer than page_size of results.

  ## Examples:

      iex> ThinNotionApi.Databases.create_database!("9b4a624d5a18482ab2187e54166edda7", "New Database")
      {:ok, %{...}}
  """
  @spec create_database!(String.t(), String.t(), map()) :: Types.Response.t()
  def create_database!(
        parent_id,
        title,
        properties \\ %{
          Name: %{
            title: %{}
          }
        }
      ) do
    body_params =
      %{}
      |> set_parent(parent_id)
      |> Properties.set_title(title)
      |> Properties.set_database_properties(properties)

    post("databases", body_params)
  end

  @spec update_database!(String.t(), String.t(), map()) :: Types.Response.t()
  @doc """
  Updates an existing database as specified by the parameters.

  ## Examples:

      iex> ThinNotionApi.Databases.update_database!(database_id, "New New Database Name")
      {:ok, %{...}}
  """
  def update_database!(
        database_id,
        title,
        properties \\ %{
          Name: %{
            title: %{}
          }
        }
      ) do
    body_params =
      %{}
      |> Properties.set_title(title)
      |> Properties.set_database_properties(properties)

    patch("databases/#{database_id}", body_params)
  end

  defp set_parent(map, parent_id) do
    Map.put(map, :parent, %{
      type: "page_id",
      page_id: parent_id
    })
  end
end
