# ExUnit timeout: ExUnit.configure(timeout: 5_000_000)

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, :manual)
