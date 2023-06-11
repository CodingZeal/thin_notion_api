# ThinNotionApi

ThinNotionApi is an Elixir package to easily communicate with the Notion API.
The main objective to provide a simple straight forward way for a person to fetch or update information without a large or complex interface.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `thin_notion_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:thin_notion_api, "~> 1.0.1"}
  ]
end
```

Next log in to the [Notion Developers](https://developers.notion.com/) site. Visit [My Integrations](https://www.notion.so/my-integrations) and create `New Integration`. After creating your integration, you should now have a `Internal Integration Token` you will use for all your Notion API requests. Make sure to keep this secret private and never leak it because at the moment you cannot regenerate a new one if compromised.

Add your integration token and which [Version of the Notion API](https://developers.notion.com/reference/versioning) you are using (if not provided, it will default to `2021-08-16`) to config/config.exs:

```elixir
config :thin_notion_api, :api_key, System.get_env("NOTION_API_KEY")
config :thin_notion_api, :notion_version, System.get_env("NOTION_VERSION")
```

You are good to go.

## Usage

Retrieve information about a Notion database
```elixir
iex> ThinNotionApi.Databases.retrieve_database(database_id)
{
  :ok,
  %{...}
}
```

Retrieves a Page object using the ID specified.
Responses contains page properties, not page content. To fetch page content, use the retrieve block children endpoint.

```elixir
iex> ThinNotionApi.Pages.retrieve_page(page_id)
{
  :ok,
  %{...}
}
```

Find all modules and functions you can use in the [API Reference section](https://hexdocs.pm/thin_notion_api/api-reference.html).

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/thin_notion_api](https://hexdocs.pm/thin_notion_api).


## v2021 Supported Features

- [x] List database
- [x] Query database
- [x] Page object actions
- [x] Block actions
- [x] User actions
- [x] Search

## Development Progress

TODO:
- [ ] Support changes for [2022-06-28](https://developers.notion.com/changelog/releasing-notion-version-2022-06-28])
- [ ] Support changes for [version 2022-02-22](https://developers.notion.com/reference/changes-by-version)

## Release Process

Validate documentation by generating using following command
```
mix docs
```

You can spin up a quick web server to host documentation if you have node installed by using the following command:
```
npx http-serve doc
```

Ensure version in the `mix.exs` has been properly incremented.

If everything looks good, you can release by running.
```
mix hex.publish
```
