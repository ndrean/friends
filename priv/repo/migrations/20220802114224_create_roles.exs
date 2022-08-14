defmodule MyApp.Repo.Migrations.CreateEnumActorStatus do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE actor_status AS ENUM ('celeb', 'blist')"
    drop_query = "DROP TYPE actor_status"
    execute(create_query, drop_query)

    # alter table(:actors) do
    #   add(:status, :actor_status)
    # end
  end
end
