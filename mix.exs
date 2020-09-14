defmodule Neo.MixProject do
  use Mix.Project

  def project do
    [
      app: :neo,
      description: "A fresh way to model state",
      package: %{
        licenses: ["MIT"],
        links: %{}
      },
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:amnesia, "~> 0.2.7"},
      {:datalog, "~> 2.0"}
    ]
  end
end
