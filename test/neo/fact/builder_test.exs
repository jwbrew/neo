defmodule Neo.Fact.BuilderTest do
  use ExUnit.Case

  test "builds regular query" do
    assert Movies.query() == [
             {:goal, :goal, [:_, :_, :_, :_]},
             {:source, Neo.Event, [:e, :a, :v]},
             {:horn, :goal, [:id, :title, :director, :year],
              [
                %{@: Neo.Event, _: [:id, "Elixir.Movies.Movie.Year", :year]},
                %{@: Neo.Event, _: [:id, "Elixir.Movies.Movie.Title", :title]},
                %{@: Neo.Event, _: [:id, "Elixir.Movies.Movie.Director", :did]},
                %{@: Neo.Event, _: [:did, "Elixir.Movies.Actor.Name", :director]}
              ]}
           ]
  end

  test "build substituted query" do
    assert Movies.query(year: 1987) == [
             {:goal, :goal, [:_, :_, :_]},
             {:source, Neo.Event, [:e, :a, :v]},
             {:horn, :goal, [:id, :title, :director],
              [
                %{@: Neo.Event, _: [:id, "Elixir.Movies.Movie.Year", 1987]},
                %{@: Neo.Event, _: [:id, "Elixir.Movies.Movie.Title", :title]},
                %{@: Neo.Event, _: [:id, "Elixir.Movies.Movie.Director", :did]},
                %{@: Neo.Event, _: [:did, "Elixir.Movies.Actor.Name", :director]}
              ]}
           ]
  end
end
