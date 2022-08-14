import Config

config :my_app, Movies.Repo,
  database: "my_app_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

# config :my_app, MyApp.Repo,
#   database: "my_app_repo",
#   username: "postgres",
#   password: "pass",
#   hostname: "localhost",
#   migration_timestamps: [type: :utc_datetime]

config :my_app,
  ecto_repos: [MyApp.Repo]

import_config "#{Mix.env()}.exs"
