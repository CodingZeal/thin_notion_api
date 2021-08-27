defmodule ThinNotionApi.Properties do
  @moduledoc false

  def set_page_parent(map, id) do
    Map.put(map, :parent, %{
      page_id: id
    })
  end

  def set_database_parent(map, id) do
    Map.put(map, :parent, %{
      database_id: id
    })
  end

  def set_title(map, title) do
    Map.put(map, :title, [%{
      type: "text",
      text: %{
          content: title
      }
    }])
  end

  def set_database_properties(map, properties) do
    case Enum.any?(Map.values(properties), fn (value) -> Map.has_key?(value, :title) end) do
      true ->
        Map.put(map, :properties, properties)
      _ ->
        raise "You must have exactly one database property schema object of type 'title' in your properties."
    end
  end
end
