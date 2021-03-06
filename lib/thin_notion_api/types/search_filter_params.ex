defmodule ThinNotionApi.Types.SearchFilterParams do
  @typedoc """
  Parameters for the filtering search results.
  """

  @type t :: %__MODULE__{
    value: String.t(),
    property: String.t(),
  }

  defstruct [:value, :property]
end
