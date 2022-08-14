import Config

config :my_app, MyApp.Repo,
  database: "my_app_repo",
  username: "postgres",
  password: "pass",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  migration_timestamps: [type: :utc_datetime]

# ownership_timeout: 999_999

# Postgres connection timeout => ownership_timeout
