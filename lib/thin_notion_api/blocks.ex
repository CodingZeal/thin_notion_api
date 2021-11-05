defmodule ThinNotionApi.Blocks do
  @moduledoc """
  This module contains functions to interact and modify Notion blocks.
  """

  import ThinNotionApi.Base
  alias ThinNotionApi.Properties

  def retrieve_block(block_id) do
    get("blocks/" <> block_id)
  end
end
