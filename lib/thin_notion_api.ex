defmodule ThinNotionApi do
  @moduledoc """
  Functions not specific to any particular model in the Notion API. Such as search.
  """

  import ThinNotionApi.Base

  @doc """
  Searches all pages and child pages that are shared with the integration. The results may include databases.
  The query parameter matches against the page titles. If the query parameter is not provided, the response will contain all pages (and child pages) in the results.
  The filter parameter can be used to query specifically for only pages or only databases.
  The response may contain fewer than page_size of results. See Pagination for details about how to use a cursor to iterate through the list.

  iex> ThinNotionApi.search(%{ query: "test", page_size: 10 })

  {:ok, %{...}}
  """
  @spec search(ThinNotionApi.Types.SearchParams.t()) :: any
  def search(%ThinNotionApi.Types.SearchParams{} = search_params) do
    post("search", search_params)
  end
end
