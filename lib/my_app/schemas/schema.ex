defmodule MyApp.Schema do
  @moduledoc """
  For uuid
  """

  defmacro __using__() do
    quote do
      use Ecto.Schema
      @primary_key {:uuid, Ecto.UUID, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
