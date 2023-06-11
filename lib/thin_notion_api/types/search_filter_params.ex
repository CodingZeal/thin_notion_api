defmodule ThinNotionApi.Types.SearchFilterParams do
  @moduledoc """
  Defines the options for the filtering search results
  """

  @typedoc """
  Parameters for the filtering search results.
  """
  @type t :: %__MODULE__{
    value: String.t(),
    property: String.t(),
  }

  defstruct [:value, :property]
end
