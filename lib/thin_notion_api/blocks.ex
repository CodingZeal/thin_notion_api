defmodule ThinNotionApi.Blocks do
  @moduledoc """
  This module contains functions to interact and modify Notion blocks.

  A block object represents content within Notion. Blocks can be text, lists, media, and more. A page is a type of block, too!
  """

  import ThinNotionApi.Base
  alias ThinNotionApi.Properties

  @doc """
  Retrieves a Block object using the ID specified.

  iex> ThinNotionApi.Blocks.retrieve_block(block_id)

  {:ok, %{...}}
  """
  def retrieve_block(block_id) do
    get("blocks/" <> block_id)
  end

  @spec retrieve_block_children(String.t(), %{ start_cursor: String.t(), page_size: Integer.t() }) :: any
  def retrieve_block_children(block_id, params \\ %{}) do
    get("blocks/" <> block_id <> "/children", params)
  end

  def update_block(block_id, body_params) do
    patch("blocks/" <> block_id, body_params)
  end
end
