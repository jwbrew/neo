defmodule Neo.QueryTest do
  use ExUnit.Case
  import Neo.Query

  defmodule User.FirstName, do: use(Neo.Event)
  defmodule User.LastName, do: use(Neo.Event)
  defmodule User.Age, do: use(Neo.Event)

  test "commits and retrieves an event" do
    User.FirstName.add(1, "James")
    User.FirstName.add(1, "John")
    User.Age.add(2, 2)
    User.Age.add(1, 10)

    fact :id, :title do
      [Movie.Year.fact(:id, 1987)]
    end

    #   [where: {@e, User.FirstName, "John"})]
    # end
    # assert result == [1]
  end
end

# q = :datalog.p('
# ?- h(_, _).
# f(s, p, o).
# h(s, title) :-
#     f(s, \"year\", 1987),
#     f(s, \"title\", title).
# ')
# IO.inspect(q)
# e = :datalog.c(:datalog_list, q)
# s = :datalog.q(e, [{:a, 1}, {:b, 2}, {:c, 3}])
# IO.inspect(s)
# # assert ids == [1]
