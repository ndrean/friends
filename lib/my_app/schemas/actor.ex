defmodule Actor do
  use Ecto.Schema
  import Ecto.Changeset
  # import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "actors" do
    field(:name, :string)
    field(:celebrity, :boolean, virtual: true)
    field(:status, Ecto.Enum, values: [:celeb, :blist])
    has_many(:contracts, Contract)
    many_to_many(:movies, Movie, join_through: "contracts")
    many_to_many(:characters, Character, join_through: "roles")
    timestamps()
  end

  def changeset(%Actor{} = actor, attrs) do
    actor
    |> cast(attrs, [:name, :celebrity])
    |> validate_required([:name])
    # |> validate_acceptance(:celebrity)
    # |> validate_acceptance(:celebrity, &(&1 === true))
    |> unique_constraint(:name)
  end

  def save(attrs) do
    Actor.changeset(%Actor{}, attrs)
    |> MyApp.Repo.insert()
  end
end
