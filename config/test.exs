import Config

config :my_app, MyApp.Repo,
  database: "my_app_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  migration_timestamps: [type: :utc_datetime]
