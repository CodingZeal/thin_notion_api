defmodule ThinNotionApi.Types.FilterParams do
  @moduledoc """
  Options for the filtering results
  """

  @type t :: %__MODULE__{
    value: String.t(),
    property: String.t(),
  }

  defstruct [:value, :property]
end
