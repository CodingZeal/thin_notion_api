defmodule ThinNotionApi.Types.PaginationParams do
  @moduledoc """
  Parameters for pagination.
  """

  @type t :: %__MODULE__{
    start_cursor: String.t(),
    page_size: integer()
  }

  @derive Jason.Encoder
  defstruct [:start_cursor, :page_size]
end
