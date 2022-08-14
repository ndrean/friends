defmodule MyApp.Repo.Migrations.AlterTableProducers do
  use Ecto.Migration

  def change do
    alter table("producers") do
      add :address, :text
      modify :name, :string
    end
  end
end
