defmodule ThinNotionApi.Types.SearchParams do
  @moduledoc """
  Keys for the search API.
  """

  @type t :: %__MODULE__{
    query: String.t(),
    sort: ThinNotionApi.Types.Sort.t(),
    filter: ThinNotionApi.Types.Filter.t(),
    start_cursor: String.t(),
    page_size: integer()
  }

  @derive Jason.Encoder
  defstruct [:query, :sort, :filter, :start_cursor, :page_size]
end
