defmodule ThinNotionApi.Parser do
  @moduledoc false

  @type headers :: map
  @type response ::
          {:ok, struct}
          | {:error, map}
          | any

  @doc """
  Parses the response from API calls
  """
  @spec parse(tuple) :: response
  def parse({:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}})
      when status in [200, 201],
      do: {:ok, parse_response_body(body)}

  def parse({:error, %HTTPoison.Error{id: _, reason: reason}}), do: {:error, %{reason: reason}}

  def parse({:ok, %HTTPoison.Response{body: body, headers: _}}),
    do: {:error, parse_response_body(body)}

  def parse(response), do: response

  defp parse_response_body(body), do: Jason.decode!(body)
end
