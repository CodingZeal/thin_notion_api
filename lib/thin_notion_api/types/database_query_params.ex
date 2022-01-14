defmodule ThinNotionApi.Types.DatabaseQueryParams do
  @typedoc """
  Parameters for using the database query API.
  """
  @type t :: %__MODULE__{
    sort: ThinNotionApi.Types.DatabaseQuerySortParams.t(),
    filter: map(),
    start_cursor: String.t(),
    page_size: integer()
  }

  @derive Jason.Encoder
  defstruct [:sort, :filter, :start_cursor, :page_size]
end
