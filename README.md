# Exploring Entity Relationship Diagrams

Summary of tools DOT, PUML, DBML [in this post](https://dev.to/ndrean/til-about-entity-relationship-schemas-16np)

## Some queries to test

Run `mix test`

or

Seed (`mix run test/seeds.exs`) then queries in IEX:

- nested tables "1<n" and "n<1"

```elixir
@doc """
  Nesting with "has_many" and "n-1: belongs_to" (1<n)(1<n)(1<n)(n<1)
"""
def producer_actors(name) do
  Repo.get_by(Producer, name: name)
  |> Repo.preload(movies: [characters: [contracts: :actor]])
end

@doc"""
Single query
"""
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
```

- "n-n" between Actor and Character through Contract

```elixir
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
```

## Ecto - cheat sheet

[Elixir CI pipeline](https://curiosum.com/blog/mastering-elixir-ci-pipeline)

[drop db between test in elixir](https://code.krister.ee/how-to-drop-database-between-tests-in-elixir/)

- associations:
[Ecto.assoc](https://hexdocs.pm/ecto/Ecto.html#assoc/3)
<https://blog.appsignal.com/2020/11/10/understanding-associations-in-elixir-ecto.html>
<https://lostkobrakai.svbtle.com/a-case-against-many_to_many>

- enum type:
[Source D Beatty](https://dennisbeatty.com/use-the-new-enum-type-in-ecto-3-5/)

- custom validation
[Custom validation](https://elixirschool.com/en/lessons/ecto/changesets)

- constraint errors
 <https://hexdocs.pm/ecto/constraints-and-upserts.html#checking-for-constraint-errors>

Works for individual:

```elixir
p = Repo.all(Producer, name: "P1")
Ecto.assoc(p, ::movies) |> Repo.all()
# all movies of p
```

and also for lists

```elixir
ps = Repo.all(Producer) => all the p
Ecto.assoc(p, :movies) |> Repo.all()
```

=> all the associations, pipe style:

Producer
|> join(:inner, [p], m in assoc(p, :movie))
|> preload([_, m], movie: m)
|> Repo.all()

## Git - remove node_modules :)

Remove node_modules from git add .
=> `git rm -r --cached .`

## Bash fancy output trick: green color

T
`\033[0;32m  \u2714 \033[0m` will produce a green check mark (`\u2714`)
