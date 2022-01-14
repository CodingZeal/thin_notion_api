defmodule ThinNotionApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :thin_notion_api,
      version: "1.0.0",
      package: package(),
      description: description(),
      source_url: "https://github.com/CodingZeal/thin_notion_api",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support", "test/helpers"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:exvcr, "~> 0.13", only: :test},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:mix_test_interactive, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Thin API wrapper for the Notion API."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/CodingZeal/thin_notion_api"}
    ]
  end
end
