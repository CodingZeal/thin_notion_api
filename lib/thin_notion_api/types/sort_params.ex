defmodule ThinNotionApi.Types.SortParams do
  @moduledoc """
  Options for the sorting results
  """

  @type t :: %__MODULE__{
    direction: :ascending | :decending,
    timestamp: String.t(),
  }

  defstruct [:direction, :timestamp]
end
