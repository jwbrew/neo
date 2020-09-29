defmodule Neo.Fact do
  require Amnesia
  require Amnesia.Helper

  defmacro __using__(source: source) do
    quote do
      import Neo.Fact

      @query []
      @goal :goal
      @source unquote(source)

      @before_compile Neo.Fact
    end
  end

  defmacro select(vars, do: {:__block__, [], lines}) do
    quote do
      @query [Neo.Fact.Builder.goal(@goal, unquote(vars)) | @query]
      @query [Neo.Fact.Builder.source(@source) | @query]

      @query [
        {:horn, @goal, unquote(vars), unquote(Enum.map(lines, &Neo.Fact.Builder.line/1))}
        | @query
      ]
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def query(subs \\ []),
        do:
          @query
          |> Enum.reverse()
          |> Neo.Fact.Builder.substitute(subs)
    end
  end
end
