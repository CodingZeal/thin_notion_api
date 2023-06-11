defmodule ThinNotionApi.Types.Response do
  @moduledoc """
  Defines the response types for the API.
  """

  @typedoc """
  Response from the API, can either be a success or an error.
  """
  @type t :: {:ok, map()} | {:error, any()}
end
