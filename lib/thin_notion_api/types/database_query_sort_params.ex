defmodule ThinNotionApi.Types.DatabaseQuerySortParams do
  @moduledoc """
  Defines the options for the sorting the database query results
  """

  @typedoc """
  Parameter options for the sorting the database query results
  """
  @type t :: %__MODULE__{
    property: String.t(),
    direction: :ascending | :descending,
    timestamp: :created_time | :last_edited_time
  }

  defstruct [:property, :direction, :timestamp]
end
