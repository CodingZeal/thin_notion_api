use Mix.Config

config :thin_notion_api, :api_key, System.get_env("NOTION_API_KEY")
config :thin_notion_api, :notion_version, System.get_env("NOTION_VERSION")
