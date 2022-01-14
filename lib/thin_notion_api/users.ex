defmodule ThinNotionApi.Users do
  @moduledoc """
  This module contains functions to interact and modify Notion users.
  """

  import ThinNotionApi.Base
  alias ThinNotionApi.Types

  @doc """
  Retrieves a User using the ID specified.

  ## Examples
      iex> ThinNotionApi.Users.retrieve_user("12345")
      {:ok, %{...}}
  """
  @spec retrieve_user(String.t()) :: Types.Response.response()
  def retrieve_user(user_id) do
    get("users/" <> user_id)
  end

  @doc """
  Returns a paginated list of Users for the workspace. The response may contain fewer than page_size of results.

  See Pagination for details about how to use a cursor to iterate through the list.

  ## Examples
      iex> ThinNotionApi.Users.list_all_users(params)

      {:ok, %{...}}
  """
  @spec list_all_users(Types.PaginationParams.t() | %{}) :: Types.Response.response()
  def list_all_users(params \\ %{}) do
    get("users", params)
  end

  @spec retrieve_user_bot :: Types.Response.response()
  @doc """
  Retrieves the bot User associated with the API token provided in the authorization header. The bot will have an owner field with information about the person who authorized the integration.

  ## Examples
      iex> ThinNotionApi.Users.retrieve_user_bot()

      {:ok, %{...}}
  """
  def retrieve_user_bot do
    get("users/me")
  end
end
