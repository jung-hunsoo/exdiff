defmodule Exdiff.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exdiff,
      version: "0.1.4",
      elixir: "~> 1.5",
      package: package(),
      name: "Exdiff",
      description: "Text difference library for Elixir",
      source_url: "https://github.com/jung-hunsoo/exdiff",
      deps: deps(),
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.16.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Jung Hun-soo"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/jung-hunsoo/exdiff"}
    ]
  end
end
