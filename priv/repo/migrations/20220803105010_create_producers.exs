defmodule MyApp.Repo.Migrations.CreateProducers do
  use Ecto.Migration

  def change do
    create table(:producers, primary_key: false ) do
      add :id, :uuid, primary_key: true
      add(:name, :string, null: false)
      timestamps()
    end

    create(unique_index(:producers, [:name]))
  end
end
