defmodule Neo.Query do
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
end
