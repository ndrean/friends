defmodule MyApp.Repo.Migrations.CreateActors do
  use Ecto.Migration

  def change do
    create table(:actors, primary_key: false) do
      add :id, :uuid, primary_key: true
      add(:name, :string, null: false)
      add(:status, :actor_status)

      timestamps()
    end

    create(unique_index(:actors, [:name]))
  end
end
