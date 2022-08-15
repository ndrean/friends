defmodule MyApp.TestConn do
  @moduledoc """
  sandbox test env
  """

  def checkout(_context \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(MyApp.Repo)
  end
end
