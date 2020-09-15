defmodule Neo.Query do
  require Amnesia
  require Amnesia.Helper

  defmacro fact(head_rule, do: expression) do
    IO.inspect(head_rule)
    IO.inspect(expression)

    quote do
      q = :datalog.p('
        ?- h(_, _).
        f(s, p, o).
        h(s, title) :-
            f(s, \"year\", 1987),
            f(s, \"title\", title).
      ')
      IO.inspect(q)
      e = :datalog.c(:datalog_list, q)
      s = :datalog.q(e, [{:a, 1}, {:b, 2}, {:c, 3}])
      IO.inspect(s)
      # assert ids == [1]
    end
  end

  def run do
    Amnesia.transaction do
      q =
        :datalog.p('?- h(_, _).
                      f(s, p, o).
                      h(s, title) :-
                        f(s, "year", 1987),
                        f(s, "title", title).
                      ')
        |> IO.inspect()

      q = [
        {:goal, :i, [:_, :_]},
        {:source, Neo.Event, [:entity, :attribute, :value]},
        {:horn, :h, [:entity, :title],
         [
           %{@: Neo.Event, _: [:entity, Movies.Movie.Year, 1987]},
           %{@: Neo.Event, _: [:entity, Movies.Movie.Title, :title]}
         ]},
        {:horn, :i, [:entity, :title],
         [
           %{@: Neo.Event, _: [:entity, Movies.Movie.Year, 1986]},
           %{@: Neo.Event, _: [:entity, Movies.Movie.Title, :title]}
         ]}
      ]

      events =
        for {:ok, event} <- Neo.Repo.Database.Event.keys() |> Enum.map(&Neo.Repo.get/1),
            do: {event.entity, event.attribute, event.value}

      events |> IO.inspect()
      IO.inspect(q)
      e = :datalog.c(:datalog_list, q)
      s = :datalog.q(e, events)
      IO.inspect(s)
    end
  end
end
