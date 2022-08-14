defmodule Contract do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias MyApp.Repo

  # @foreign_key_type :binary_id
  schema "contracts" do
    field(:salary, :float)
    belongs_to(:actor, Actor, references: :id, type: :binary_id)
    belongs_to(:character, Character)
    belongs_to(:movie, Movie)
    timestamps()
  end

  # need to pass the foreign keys otherwise discarded
  # <https://hexdocs.pm/ecto/Ecto.Changeset.html#unique_constraint/3-complex-constraints>
  def changeset(%Contract{} = contract, attrs) do
    contract
    |> cast(attrs, [:character_id, :actor_id, :movie_id, :salary])
    |> validate_required([:salary, :character_id, :movie_id, :actor_id])
    |> unique_constraint(:not_unique, name: :contract)
    |> unique_actor_movie()
    |> foreign_key_constraint(:character_id)
    |> foreign_key_constraint(:actor_id)
    |> foreign_key_constraint(:movie_id)
  end

  defp unique_actor_movie(%Ecto.Changeset{} = cs) do
    act_id = Ecto.Changeset.get_field(cs, :actor_id)
    mov_id = Ecto.Changeset.get_field(cs, :movie_id)

    list_actors =
      Contract
      |> where([c], c.movie_id == ^mov_id)
      |> where([c], c.actor_id == ^act_id)
      |> select([c], c.character_id)
      |> Repo.all()
      |> length

    case list_actors do
      0 ->
        cs

      _ ->
        add_error(cs, :character_id, "already used")
    end
  end
end
