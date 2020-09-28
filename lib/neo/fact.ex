defmodule Neo.Fact do
  require Amnesia
  require Amnesia.Helper

  defmacro __using__(source: source) do
    quote do
      import Neo.Fact

      @goal :goal
      @query []
      @source unquote(source)

      @before_compile Neo.Fact
    end
  end

  def goal(label, select) do
    {:goal, label, Enum.map(select, fn _ -> :_ end)}
  end

  def source(module), do: {:source, module, [:e, :a, :v]}

  def line({:where, _, [{:__aliases__, _, _} = a, e, v]}) do
    {:%{}, [],
     [
       @: {:__aliases__, [alias: false], [:Neo, :Event]},
       _: [
         Neo.Fact.var(e),
         {:to_string, [context: Elixir, import: Kernel], [a]},
         Neo.Fact.var(v)
       ]
     ]}
  end

  def var({:@, _, [{v, _, _}]}), do: v
  def var(x), do: x

  defmacro select(vars, do: {:__block__, [], lines}) do
    quote do
      @query [Neo.Fact.goal(@goal, unquote(vars)) | @query]
      @query [Neo.Fact.source(@source) | @query]

      @query [
        {:horn, @goal, unquote(vars), unquote(Enum.map(lines, &line/1))}
        | @query
      ]
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def query(), do: @query |> Enum.reverse() |> IO.inspect(label: "query")
    end
  end
end
