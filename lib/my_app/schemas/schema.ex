defmodule MyApp.Schema do
  # @shortdoc "make uuid available for every schema"

  defmacro __using__() do
    quote do
      use Ecto.Schema
      @primary_key {:uuid, Ecto.UUID, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
