defmodule MyApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_app,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        plt_add_deps: [:app_tree],
        plt_add_apps: [:mix]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MyApp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15"},
      {:ecto_erd, "~> 0.5", only: :dev},
      {:ecto_dev_logger, "~> 0.4", only: [:dev, :test]},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:git_hooks, "~> 0.7.3", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      # test: ["run test/seeds.exs", "test --trace"]
      test: ["ecto.drop", "ecto.create", "ecto.migrate", "run test/seeds.exs", "test --trace"]
    ]
  end
end
