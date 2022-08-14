import Config

config :my_app, MyApp.Repo,
  database: "my_app_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  migration_timestamps: [type: :utc_datetime]

if Mix.env() == :dev do
  # config :my_app, MyApp.Repo, log: false

  config :git_hooks,
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          {:cmd, "mix format --check-formatted"}
        ]
      ],
      pre_push: [
        verbose: false,
        tasks: [
          {:cmd, "mix dialyzer"},
          {:cmd, "mix test --color"},
          {:cmd, "echo 'success!'"}
        ]
      ]
    ]
end
