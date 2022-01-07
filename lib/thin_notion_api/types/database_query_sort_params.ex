defmodule ThinNotionApi.Types.DatabaseQuerySortParams do
  @moduledoc """
  Parameter options for the sorting the database query results
  """

  @type t :: %__MODULE__{
    property: String.t(),
    direction: :ascending | :decending,
    timestamp: :created_time | :last_edited_time
  }

  defstruct [:property, :direction, :timestamp]
end
