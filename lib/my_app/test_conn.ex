defmodule MyApp.TestConn do
  def checkout(_context \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(MyApp.Repo)
  end
end
