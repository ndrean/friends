defmodule DbTest do
  use ExUnit.Case, async: true
  alias MyApp.Repo
  import MyApp.TestConn, only: [checkout: 1]

  # moved into a file
  # setup do
  #   :ok = Ecto.Adapters.SQL.Sandbox.checkout(MyApp.Repo)
  # end
  setup(:checkout)

  test "Count Actors" do
    assert Repo.aggregate(Actor, :count, :id) == 4
  end

  test "Count Producers" do
    assert Repo.aggregate(Producer, :count, :name) == 2
  end

  test "Count Movies" do
    assert Repo.aggregate(Movie, :count, :id) == 3
  end

  test "Count Contracts" do
    assert Repo.aggregate(Contract, :count, :id) == 7
  end

  test "cannot create movie without producer" do
    {:error, %Ecto.Changeset{errors: errors} = changeset} =
      Movie.changeset(%Movie{}, %{title: "M4"})
      |> Repo.insert()

    refute changeset.valid?
  end

  test " producer per movie not unique" do
    # <https://hexdocs.pm/ecto/constraints-and-upserts.html#checking-for-constraint-errors>
    Producer |> Repo.get_by(name: "P2")

    {:error, %Ecto.Changeset{errors: errors} = changeset} =
      %Movie{}
      |> Movie.changeset(%{title: "M2"})
      |> Repo.insert()

    refute changeset.valid?
  end

  test "actor has at most a character per movie" do
    {:error, %Ecto.Changeset{errors: errors} = changeset} =
      Actor.changeset(%Actor{}, %{name: "A1"})
      |> Ecto.Changeset.put_assoc(:movies, [%Movie{title: "M1"}])
      |> Repo.insert()

    refute changeset.valid?
  end

  test "character can't have several movies" do
    {:error, %Ecto.Changeset{errors: errors} = changeset} =
      Character.changeset(
        %Character{},
        %{name: "C1", movie_id: Repo.get_by(Movie, title: "M2")}
      )
      |> Repo.insert()

    refute changeset.valid?
  end

  test "unique contract per movie per actor" do
    {m, a, c, s} = {"M1", "A1", "C1", 10}
    movie_id = Repo.get_by(Movie, title: m).id
    actor_id = Repo.get_by(Actor, name: a).id
    char_id = Repo.get_by(Character, name: c).id

    params = %{
      salary: s,
      movie_id: movie_id,
      actor_id: actor_id,
      character_id: char_id
    }

    {:error, %Ecto.Changeset{errors: errors} = changeset} =
      Contract.changeset(%Contract{}, params)
      |> Repo.insert()

    refute changeset.valid?
  end

  test "unique character per actor per movie" do
    {m, a, c, s} = {"M1", "A1", "C2", 11}
    movie_id = Repo.get_by(Movie, title: m).id
    actor_id = Repo.get_by(Actor, name: a).id
    char_id = Repo.get_by(Character, name: c).id

    params = %{
      salary: s,
      movie_id: movie_id,
      actor_id: actor_id,
      character_id: char_id
    }

    {:error, %Ecto.Changeset{errors: errors} = changeset} =
      Contract.changeset(%Contract{}, params)
      |> Repo.insert()

    refute changeset.valid?
  end

  test "check association actor/character" do
    assert Queries.character_actor_query("C3") == ["A3", "A2"] and
             Queries.actor_character_query("A1") == ["C1", "C2", "C4"]
  end

  test "nested association producer/actor: which actors for a given producer" do
    assert Queries.producer_actors_query("P1") == ["A1", "A2", "A3"]
  end
end
