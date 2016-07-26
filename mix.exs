defmodule ExPing.Mixfile do
  use Mix.Project

  def project do
    [app: :exping,
     description: "ExPing",
     package: package(),
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     dialyzer: dialyzer(),
     deps: deps()]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [applications: [:logger, :inets],
     mod: {ExPing.Application, []}]
  end

  defp deps do
    [{:dialyxir, "~> 0.3.5", only: :dev},
     {:credo, "~> 0.4.7", only: :dev}]
  end

  defp package do
    [maintainers: ["Kenny Ballou"],
     licenses: ["Apache 2.0"],
     links: %{"Git" => "https://git.devnulllabs.io/exping.git",
              "GitHub" => "https://github.com/kennyballou/exping.git",
              "Hex" => "https://hex.pm/packages/exping"},
     files: ~w(mix.exs README.md LICENSE lib)]
  end

  defp dialyzer do
    [plt_add_apps: [:inets], plt_add_deps: :transitive]
  end

end
