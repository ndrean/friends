defmodule Queries do
  import Ecto.Query
  alias MyApp.Repo
  require Logger

  @doc """
  Simple "has_many" (1<n) relation Producer < Movie
  """
  def producer_movies(name) do
    %Producer{movies: movies} =
      Repo.get_by(Producer, name: name)
      |> Repo.preload(:movies)

    Enum.map(movies, fn %Movie{title: title} -> title end)
  end

  def producer_movies_assoc(name) do
    list_movies =
      Repo.get_by(Producer, name: name)
      |> Ecto.assoc(:movies)
      |> Repo.all()

    Enum.map(list_movies, fn %Movie{title: title} -> title end)
  end

  @doc """
  Nested double "has_many"  1-n associations between Producer < Movie < Character
  """
  def producer_chars(name) do
    %Producer{movies: movies} =
      Repo.get_by(Producer, name: name)
      |> Repo.preload(movies: [:characters])

    {
      name,
      Enum.map(movies, fn %Movie{title: title, characters: characters} ->
        {title, Enum.map(characters, fn %Character{name: name} -> name end)}
      end)
    }
  end

  def producer_chars_query(name) do
    %Producer{movies: movies} =
      from(producer in Producer,
        where: producer.name == ^name,
        inner_join: movies in assoc(producer, :movies),
        inner_join: chars in assoc(movies, :characters),
        preload: [movies: {movies, characters: chars}]
      )
      |> Repo.one()

    {
      name,
      Enum.map(movies, fn %Movie{title: title, characters: characters} ->
        {title, Enum.map(characters, fn %Character{name: name} -> name end)}
      end)
    }
  end

  @doc """
  3 level nesting "has_many" 1<n Producer < Movie < Character < Contract
  """
  def producer_contracts(name) do
    Repo.get_by(Producer, name: name)
    |> Repo.preload(movies: [characters: :contracts])
  end

  @doc """
  Deep nesting with "has_many" and "n-1: belongs_to" (1<n)(1<n)(1<n)(n<1)
  """
  def producer_actors(name) do
    Repo.get_by(Producer, name: name)
    |> Repo.preload(movies: [characters: [contracts: :actor]])
  end

  def producer_actors_query(name) do
    from(p in Producer,
      where: p.name == ^name,
      inner_join: m in assoc(p, :movies),
      inner_join: ct in assoc(m, :contracts),
      inner_join: a in assoc(ct, :actor),
      select: a.name
    )
    |> distinct(true)
    |> Repo.all()
  end

  def actor_character(name) do
    %Actor{name: act_name, contracts: contracts} =
      Repo.get_by(Actor, name: name)
      |> Repo.preload(contracts: [:character, :movie])

    {
      act_name,
      Enum.map(contracts, fn %Contract{
                               movie: %Movie{title: title},
                               character: %Character{name: char_name}
                             } ->
        {title, char_name}
      end)
    }
  end

  @doc """
  many-to-many (1<n)(n<1)
  """
  def actor_character_query(name) do
    from(a in Actor,
      where: a.name == ^name,
      inner_join: ct in assoc(a, :contracts),
      inner_join: ch in assoc(ct, :character),
      select: ch.name
      # preload:
    )
    |> Repo.all()
  end

  @doc """
  many-to-many (1<n)(n<1)
  """
  def character_actor_query(name) do
    from(char in Character,
      where: char.name == ^name,
      inner_join: cts in assoc(char, :contracts),
      inner_join: a in assoc(cts, :actor),
      select: a.name
    )
    |> Repo.all()
  end
end
