defmodule ThinNotionApi.Pages do
  @moduledoc """
  Module for interacting with the Notion pages.
  """
  import ThinNotionApi.Base
  alias ThinNotionApi.{Properties, Types}

  @doc """
  Retrieves a Page object using the ID specified.

  Responses contains page properties, not page content. To fetch page content, use the retrieve block children endpoint.

  ## Examples:
      iex> ThinNotionApi.Pages.retrieve_page("9b4a624d5a18482ab2187e54166edda7")
      {:ok, %{...}}
  """
  @spec retrieve_page(String.t()) :: Types.Response.t()
  def retrieve_page(page_id) do
    get("pages/#{page_id}")
  end

  @doc """
  Create a page with a page or database as its parent type.

  If the parent is a database, the property values of the new page in the properties parameter must conform to the parent database's property schema.

  If the parent is a page, the only valid property is title.

  When creating a Database you must specify a title property.

  ## Examples:
      iex> ThinNotionApi.Pages.create_page(:page, "9b4a624d5a18482ab2187e54166edda7")
      {:ok, %{...}}

      iex> ThinNotionApi.Pages.create_page(:database, "ee90be7f3fd14fd5961ef4203c7d9a81", %{ "title": %{ "title": [%{ "type": "text", "text": %{ "content": "Create Page Database" } }] } })
      {:ok, %{...}}
  """
  @spec create_page(:database | :page, String.t(), map() | nil) :: Types.Response.t()
  def create_page(type, parent_id, properties \\ %{}, children \\ [])
  def create_page(:page, parent_id, properties, children) do
    body_params = %{}
    |> Properties.set_page_parent(parent_id)
    |> Map.put(:properties, properties)
    |> Map.put(:children, children)

    post("pages", body_params)
  end

  def create_page(:database, parent_id, properties, children) do
    body_params = %{}
    |> Properties.set_database_parent(parent_id)
    |> Properties.set_database_properties(properties)
    |> Map.put(:children, children)

    post("pages", body_params)
  end

  @doc """
  Update a pages properties or archive (delete) it.

  Properties that are not set via the properties parameter will remain unchanged.

  If the parent is a database, the new property values in the properties parameter must conform to the parent database's property schema.

  This endpoint is for updating page properties, not page content. To fetch page content, use the retrieve block children endpoint. To append page content, use the append block children endpoint.

  ## Examples:
      iex>  ThinNotionApi.Pages.update_page("c8445875c2cc424eb9eacba94cac667d", properties, false)
      {:ok, %{...}}
  """
  @spec update_page(String.t(), map() | nil, boolean() | nil) :: Types.Response.t()
  def update_page(page_id, properties \\ %{}, archived \\ false) do

    body_params = %{}
    |> Map.put(:properties, properties)
    |> Map.put(:archived, archived)

    patch("pages/#{page_id}", body_params)
  end

  @spec retrieve_page_property_item(String.t(), String.t(), Types.PaginationParams.t() | %{}) :: Types.Response.t()
  @doc """
  Retrieves a property_item object for a given page_id and property_id. Depending on the property type, the object returned will either be a value or a paginated list of property item values.

  ## Examples:
      iex> ThinNotionApi.Pages.retrieve_page_property_item("c8445875c2cc424eb9eacba94cac667d", "title")
      {:ok, %{...}}
  """
  def retrieve_page_property_item(page_id, property_id, params \\ %{}) do
    get("pages/#{page_id}/properties/#{property_id}", params)
  end
end
