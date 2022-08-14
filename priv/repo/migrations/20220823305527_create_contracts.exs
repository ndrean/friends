defmodule MyApp.Repo.Migrations.CreateContracts do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add(:salary, :float, null: false)
      add(:movie_id, references(:movies), null: false)
      add(:actor_id, references(:actors, type: :uuid), null: false)
      add(:character_id, references(:characters), null: false)

      timestamps()
    end

    create(unique_index(:contracts, [ :movie_id, :actor_id, :character_id], name: :contract))
  end
end
