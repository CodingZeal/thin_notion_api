import Config

config :thin_notion_api, :api_key, System.get_env("NOTION_API_KEY")
config :thin_notion_api, :notion_version, System.get_env("NOTION_VERSION")

config :exvcr, [
  vcr_cassette_library_dir: "fixture/vcr_cassettes",
  custom_cassette_library_dir: "fixture/custom_cassettes",
  filter_sensitive_data: [
    [pattern: "<PASSWORD>.+</PASSWORD>", placeholder: "PASSWORD_PLACEHOLDER"]
  ],
  filter_url_params: false,
  filter_request_headers: ["Authorization"],
  response_headers_blacklist: []
]
