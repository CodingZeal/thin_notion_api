defmodule ThinNotionApi.NotionTestHelpers do
  @moduledoc false

  @spec get_in_undasherized(map(), Array.t) :: String.t
  def get_in_undasherized(data, path) do
    data
    |> get_in(path)
    |> String.replace("-", "")
  end
end
