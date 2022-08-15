import Config

config :my_app,
  ecto_repos: [MyApp.Repo]

import_config "#{Mix.env()}.exs"
