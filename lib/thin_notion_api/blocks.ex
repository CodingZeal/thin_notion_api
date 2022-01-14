defmodule ThinNotionApi.Blocks do
  @moduledoc """
  This module contains functions to interact and modify Notion blocks.

  A block object represents content within Notion. Blocks can be text, lists, media, and more.
  """

  import ThinNotionApi.Base
  alias ThinNotionApi.Types

  @spec retrieve_block(String.t()) :: Types.Response.response()
  @doc """
  Retrieves a Block object using the ID specified.

  ## Examples:

      iex> ThinNotionApi.Blocks.retrieve_block(block_id)

      {:ok, %{...}}
  """
  def retrieve_block(block_id) do
    get("blocks/" <> block_id)
  end

  @doc """
  Returns a paginated array of child block objects contained in the block using the ID specified. In order to receive a complete representation of a block, you may need to recursively retrieve the block children of child blocks.

  🚧 Returns only the first level of children for the specified block. See block objects for more detail on determining if that block has nested children.

  The response may contain fewer than page_size of results.

  See Pagination for details about how to use a cursor to iterate through the list.

  ## Examples:

      iex> ThinNotionApi.Blocks.retrieve_block_children("9b4a624d5a18482ab2187e54166edda7")

      {:ok, %{...}}
  """
  @spec retrieve_block_children(String.t(), %{ start_cursor: String.t(), page_size: Integer.t() } | %{}) :: Types.Response.response()
  def retrieve_block_children(block_id, params \\ %{}) do
    get("blocks/" <> block_id <> "/children", params)
  end

  @doc """
  Updates the content for the specified block_id based on the block type. Supported fields based on the block object type (see Block object for available fields and the expected input for each field).

  Note: The update replaces the entire value for a given field. If a field is omitted (ex: omitting checked when updating a to_do block), the value will not be changed.

  ## Examples:

      iex> ThinNotionApi.Blocks.update_block("c4c027f4ea7c41c5908d63a7f5a9c32c", %{
            paragraph: %{
              text: [%{
                type: "text",
                text: %{
                  content: "Hello DOGE!",
                }
              }],
            }
          })

      {:ok, %{...}}
  """
  @spec update_block(String.t(), %{ archived: boolean()} | map()) :: Types.Response.response()
  def update_block(block_id, body_params) do
    patch("blocks/" <> block_id, body_params)
  end

  @spec append_block_children(String.t(), list(map())) :: Types.Response.response()
  @doc """
  Creates and appends new children blocks to the parent block_id specified.

  Returns a paginated list of newly created first level children block objects.

  ## Examples:

      iex> ThinNotionApi.Blocks.append_block_children("c4c027f4ea7c41c5908d63a7f5a9c32c", [%{
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
          }])

      {:ok, %{...}}
  """
  def append_block_children(block_id, children) do
    patch("blocks/" <> block_id <> "/children", %{ children: children })
  end

  @doc """
  Sets a Block object, including page blocks, to archived: true using the ID specified. Note: in the Notion UI application, this moves the block to the "Trash" where it can still be accessed and restored.

  To restore the block with the API, use the Update a block or Update page respectively.

  ## Examples:

      iex> ThinNotionApi.Blocks.delete_block("9b4a624d5a18482ab2187e54166edda7")

      {:ok, %{...}}
  """
  @spec delete_block(String.t()) :: Types.Response.response()
  def delete_block(block_id) do
    delete("blocks/" <> block_id)
  end
end
