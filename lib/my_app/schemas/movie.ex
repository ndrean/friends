defmodule Movie do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  schema "movies" do
    field(:title, :string)
    has_many(:characters, Character)
    has_many(:contracts, Contract)
    belongs_to(:producer, Producer)
    timestamps()
  end

  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :producer_id])
    |> validate_required([:title, :producer_id])
    |> foreign_key_constraint(:producer_id)
  end
end
