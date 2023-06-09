import Config

config :thin_notion_api, :api_key, "test_api_key"
config :thin_notion_api, :notion_version, "2021-08-16"

config :exvcr,
  vcr_cassette_library_dir: "fixture/vcr_cassettes",
  custom_cassette_library_dir: "fixture/custom_cassettes",
  filter_sensitive_data: [
    [pattern: "<PASSWORD>.+</PASSWORD>", placeholder: "PASSWORD_PLACEHOLDER"]
  ],
  filter_url_params: false,
  filter_request_headers: ["Authorization"],
  response_headers_blacklist: []
