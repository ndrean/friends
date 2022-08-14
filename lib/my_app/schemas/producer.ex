defmodule Producer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "producers" do
    field(:name, :string)
    has_many(:movies, Movie)
    timestamps()
  end

  def changeset(%Producer{} = producer, attrs) do
    producer
    |> cast(attrs, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name)
  end

  def save(attrs) do
    Producer.changeset(%Producer{}, attrs)
    |> MyApp.Repo.insert()
  end
end
