defmodule MyApp.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add(:title, :string, null: false)
      add(:producer_id, references(:producers, type: :uuid), null: false)

      timestamps()
    end

    create(unique_index(:movies, [:title]))
  end
end
