defmodule ThinNotionApi.Types.SearchSortParams do
  @moduledoc """
  Parameter options for the sorting the search results
  """

  @type t :: %__MODULE__{
    direction: :ascending | :decending,
    timestamp: String.t(),
  }

  defstruct [:direction, :timestamp]
end
