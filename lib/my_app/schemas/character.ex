defmodule Character do
  use Ecto.Schema
  # use MyApp.Schema
  import Ecto.Changeset

  schema "characters" do
    field(:name, :string)
    belongs_to(:movie, Movie)
    has_many(:contracts, Contract)
    many_to_many(:actors, Actor, join_through: "roles")
    timestamps()
  end

  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :movie_id])
    |> validate_required([:name, :movie_id])
    |> unique_constraint(:name)
    |> unique_constraint([:movie_id, :character_id])
    |> foreign_key_constraint(:movie_id)
  end

  def create(params) do
    %Character{}
    |> changeset(params)
  end
end
