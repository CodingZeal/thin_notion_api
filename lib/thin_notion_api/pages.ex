defmodule ThinNotionApi.Pages do
  import ThinNotionApi.Base

  def retrieve_page(page_id) do
    get("pages/#{page_id}")
  end
end
