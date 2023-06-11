defmodule ThinNotionApi.Types.SearchParams do
  @moduledoc """
  Defines parameters for using the search API.
  """

  @typedoc """
  Parameters for using the search API.
  """
  @type t :: %__MODULE__{
    query: String.t(),
    sort: ThinNotionApi.Types.SearchSortParams.t(),
    filter: ThinNotionApi.Types.SearchFilterParams.t(),
    start_cursor: String.t(),
    page_size: integer()
  }

  @derive Jason.Encoder
  defstruct [:query, :sort, :filter, :start_cursor, :page_size]
end
