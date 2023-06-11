defmodule ThinNotionApi.Types.SearchSortParams do
  @moduledoc """
  Defines the options for the sorting the search results
  """

  @typedoc """
  Parameter options for the sorting the search results
  """
  @type t :: %__MODULE__{
    direction: :ascending | :descending,
    timestamp: String.t(),
  }

  defstruct [:direction, :timestamp]
end
