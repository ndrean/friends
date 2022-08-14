defmodule Seeds do
  alias MyApp.Repo

  def run do
    # check Ecto.multi??

    Repo.transaction(fn ->
      # ACTOR
      [{"A1", "celeb"}, {"A2", "blist"}, {"A3", "celeb"}, {"A4", "blist"}]
      |> Enum.each(fn {n, s} -> Actor.save(%{name: n, status: s}) end)

      # PRODUCER
      ["P1", "P2"]
      |> Enum.each(&Producer.save(%{name: &1}))

      # ---------------------------
      producers = Repo.all(Producer)

      [{"P1", "M1"}, {"P1", "M2"}, {"P2", "M3"}]
      |> Enum.each(fn {p, n} ->
        %{
          title: n,
          producer_id: Enum.find(producers, &(&1.name == p)).id
        }
        |> then(&Movie.changeset(%Movie{}, &1))
        |> Repo.insert()
      end)

      # ---------------------------
      movies = Repo.all(Movie)

      [{"C1", "M1"}, {"C2", "M1"}, {"C3", "M2"}, {"C4", "M3"}]
      |> Enum.each(fn {c, m} ->
        %{
          name: c,
          movie_id: Enum.find(movies, &(&1.title == m)).id
        }
        |> then(&Character.changeset(%Character{}, &1))
        |> Repo.insert()
      end)

      # ---------------------------
      movies = Repo.all(Movie)
      actors = Repo.all(Actor)
      characters = Repo.all(Character)

      [
        {"M1", "A1", "C1", 9},
        {"M1", "A2", "C1", 10},
        {"M1", "A3", "C2", 12},
        {"M2", "A1", "C2", 13},
        {"M2", "A3", "C3", 14},
        {"M2", "A2", "C3", 15},
        {"M3", "A1", "C4", 17}
      ]
      |> Enum.each(fn {m, a, c, s} ->
        params = %{
          salary: s,
          movie_id: Enum.find(movies, &(&1.title == m)).id,
          actor_id: Enum.find(actors, &(&1.name == a)).id,
          character_id: Enum.find(characters, &(&1.name == c)).id
        }

        Contract.changeset(%Contract{}, params)
        |> Repo.insert!()
      end)
    end)
  end

  _group_assoc = fn l ->
    # l = [{"M1", "C1"}, {"M1", "C2"}, {"M2", "C3"}]
    l
    |> Enum.map(fn {m, c} -> %{m: m, c: c} end)
    # list_maps = [%{m: "M1", c: "C1"}, %{m: "M1", c: "C2"}, %{m: "M2", c: "C3"}]
    |> Enum.group_by(& &1.m)
    |> Enum.map(fn {k, v} ->
      %{m: k, c: Enum.reduce(v, [], fn e, acc -> [e.c | acc] end)}
    end)
  end

  # => [%{c: ["C2", "C1"], m: "M1"}, %{c: ["C3"], m: "M2"}]ex
end

Seeds.run()
