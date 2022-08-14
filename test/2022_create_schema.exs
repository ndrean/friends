defmodule MyApp.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def up do
    execute("""
    CREATE TABLE "actors" ("id" int PRIMARY KEY,"name" varchar UNIQUE NOT NULL,"created_at" timestamp);
    """)

    execute("""
    CREATE TABLE "producers" ("id" int PRIMARY KEY,"name" varchar UNIQUE NOT NULL,"created_at" timestamp);
    """)

    execute("""
    CREATE TABLE "characters" ("id" int PRIMARY KEY,"name" varchar UNIQUE NOT NULL,"created_at" timestamp,"movie_id" int UNIQUE NOT NULL);
    """)

    execute("""
    CREATE TABLE "movies" ("id" int PRIMARY KEY,"name" varchar UNIQUE NOT NULL,"created_at" timestamp,"producer_id" int UNIQUE NOT NULL);
    """)

    execute("""
    CREATE TABLE "contracts" ("id" int PRIMARY KEY,"amount" float, "created_at" timestamp,"actor_id" int NOT NULL,"movie_id" int NOT NULL,"character_id" int NOT NULL);
    """)

    execute("""
    CREATE UNIQUE INDEX ON "actors" ("name");
    """)

    execute("""
    CREATE UNIQUE INDEX ON "producers" ("name");
    """)

    execute("""
    CREATE UNIQUE INDEX ON "characters" ("name");
    """)

    execute("""
    CREATE UNIQUE INDEX ON "movies" ("name");
    """)

    execute("""
    CREATE UNIQUE INDEX "contract" ON "contracts" ("actor_id","movie_id","character_id");
    """)

    execute("""
    CREATE UNIQUE INDEX "movie_role_per_actor" ON "contracts" ("actor_id","movie_id");
    """)

    execute("""
    ALTER TABLE "characters" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
    """)

    execute("""
    ALTER TABLE "movies" ADD FOREIGN KEY ("producer_id") REFERENCES "producers" ("id");
    """)

    execute("""
    ALTER TABLE "contracts" ADD FOREIGN KEY ("actor_id") REFERENCES "actors" ("id");
    """)

    execute("""
    ALTER TABLE "contracts" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");
    """)

    execute("""
    ALTER TABLE "contracts" ADD FOREIGN KEY ("character_id") REFERENCES "characters" ("id");
    """)
  end

  def down do
    execute("drop table posts;")
  end
end
