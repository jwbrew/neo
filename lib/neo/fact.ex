defmodule Neo.Fact do
  require Amnesia
  require Amnesia.Helper

  defmacro __using__(source: source, select: select) do
    quote do
      import Neo.Fact

      @goal :h

      def query(),
        do:
          [
            Neo.Fact.goal(@goal, unquote(select)),
            Neo.Fact.source(unquote(source)),
            {:horn, @goal, [:id, :title, :director],
             [
               %{@: Neo.Event, _: [:id, to_string(Movies.Movie.Year), 1987]},
               %{@: Neo.Event, _: [:id, to_string(Movies.Movie.Title), :title]},
               %{@: Neo.Event, _: [:id, to_string(Movies.Movie.Director), :did]},
               %{@: Neo.Event, _: [:did, to_string(Movies.Actor.Name), :director]}
             ]}
          ]
          |> IO.inspect()
    end
  end

  def goal(label, select) do
    {:goal, label, Enum.map(select, fn _ -> :_ end)}
  end

  def source(module), do: {:source, module, [:e, :a, :v]}

  defmacro fact(do: expression) do
    IO.inspect(expression)

    quote do
    end
  end

  defmacro where(entity, attribute, value) do
    IO.inspect({entity, attribute, value})
  end
end
