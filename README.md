# Ecto - cheat sheet

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
Repo.all(Ecto.assoc(p, ::movies))
# all movies of p
```

and also for lists

```elixir
ps = Repo.all(Producer) => all the p
Repo.all(Ecto.assoc(p, :movies))
```

=> all the associations

Producer
|> join(:inner, [p], m in assoc(p, :movie))
|> preload([_, m], movie: m)
|> Repo.all()

[GIT] Remove node_modules from git add .
=> `git rm -r --cached .`

- fancy trick:
`\033[0;32m \xE2\x9C\x94 \033[0m` will produce a green tick
