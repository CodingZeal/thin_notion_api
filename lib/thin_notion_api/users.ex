defmodule ThinNotionApi.Users do
  @moduledoc """
  This module contains functions to interact and modify Notion users.
  """

  import ThinNotionApi.Base

  @doc """
  Retrieves a User using the ID specified.

  iex> ThinNotionApi.Users.retrieve_user("12345")

  {:ok, %{...}}
  """
  @spec retrieve_user(String.t()) :: any
  def retrieve_user(user_id) do
    get("users/" <> user_id)
  end

  @doc """
  Returns a paginated list of Users for the workspace. The response may contain fewer than page_size of results.

  See Pagination for details about how to use a cursor to iterate through the list.

  iex> ThinNotionApi.Users.list_all_users(params)

  {:ok, %{...}}
  """
  @spec list_all_users(map) :: any
  def list_all_users(params \\ %{}) do
    get("users", params)
  end

  # @spec retrieve_user_bot :: any
  # def retrieve_user_bot do
  #   get("users/me")
  # end
end
