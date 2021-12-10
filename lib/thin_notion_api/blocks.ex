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

  @spec update_block(binary, any) :: any
  def update_block(block_id, body_params) do
    patch("blocks/" <> block_id, body_params)
  end

  @spec append_block_cildren(String.t(), list()) :: any
  @doc """
  Creates and appends new children blocks to the parent block_id specified.

  Returns a paginated list of newly created first level children block objects.
  """
  def append_block_cildren(block_id, children) do
    patch("blocks/" <> block_id <> "/children", %{ children: children })
  end

  @doc """
  Sets a Block object, including page blocks, to archived: true using the ID specified. Note: in the Notion UI application, this moves the block to the "Trash" where it can still be accessed and restored.

  To restore the block with the API, use the Update a block or Update page respectively.
  """
  def delete_block(block_id) do
    delete("blocks/" <> block_id)
  end
end
