defmodule MyApp.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add(:name, :string, null: false)
      add(:movie_id, references(:movies), null: false)

      timestamps()
    end

    create(unique_index(:characters, [:name]))
  end
end
