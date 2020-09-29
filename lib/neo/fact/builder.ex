defmodule Neo.Fact.Builder do
  @moduledoc """
  Tranlates the Elixir DSL into a query that :datalog can
  process
  """

  def goal(label, select) do
    {:goal, label, Enum.map(select, fn _ -> :_ end)}
  end

  def source(module), do: {:source, module, [:e, :a, :v]}

  def line({:where, _, [{:__aliases__, _, _} = a, e, v]}) do
    {:%{}, [],
     [
       @: {:__aliases__, [alias: false], [:Neo, :Event]},
       _: [
         var(e),
         {:to_string, [context: Elixir, import: Kernel], [a]},
         var(v)
       ]
     ]}
  end

  def var({:@, _, [{v, _, _}]}), do: v
  def var(x), do: x

  def substitute(list, subs) when is_list(list), do: Enum.map(list, &substitute(&1, subs))
  # Naively assume that this keyword exists and remove it from the set
  def substitute({:goal, ref, vars}, subs), do: {:goal, ref, Enum.drop(vars, Enum.count(subs))}
  def substitute({:source, _, _} = source, _subs), do: source

  def substitute({:horn, ref, vars, lines}, subs),
    do: {:horn, ref, vars -- Keyword.keys(subs), Enum.map(lines, &substitute(&1, subs))}

  def substitute(%{@: _source, _: vars} = line, subs),
    do: %{line | _: Enum.map(vars, &substitute(&1, subs))}

  def substitute(atom, subs) when is_atom(atom), do: Keyword.get(subs, atom, atom)
  def substitute(other, _subs), do: other
end
