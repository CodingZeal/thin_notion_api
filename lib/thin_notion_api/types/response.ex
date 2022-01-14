defmodule ThinNotionApi.Types.Response do
  @typedoc """
  Response from the API, can either be a success or an error.
  """
  @type t :: {:ok, map()} | {:error, any()}
end
