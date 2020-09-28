defmodule Neo.FactTest do
  use ExUnit.Case

  test "successfully queries a raw fact" do
    defmodule RawFact do
      use Neo.Fact, source: Neo.Event, select: [:id, :title, :director]

      @raw [
        {:goal, :h, [:_, :_, :_]},
        {:source, Neo.Event, [:e, :a, :v]},
        {:horn, :h, [:id, :title, :director],
         [
           %{@: Neo.Event, _: [:id, to_string(Movies.Movie.Year), 1987]},
           %{@: Neo.Event, _: [:id, to_string(Movies.Movie.Title), :title]},
           %{@: Neo.Event, _: [:id, to_string(Movies.Movie.Director), :did]},
           %{@: Neo.Event, _: [:did, to_string(Movies.Actor.Name), :director]}
         ]}
      ]
    end

    assert Neo.Repo.all(RawFact) == [
             ["urn:movie:202", "Predator", "John McTiernan"],
             ["urn:movie:203", "Lethal Weapon", "Richard Donner"],
             ["urn:movie:204", "RoboCop", "Paul Verhoeven"]
           ]
  end

  test "succesfully queries a macro-d fact" do
    defmodule SomeFact do
      use Neo.Fact, source: Neo.Event, select: [:id, :title, :director]

      fact do
        where(Movies.Movie.Year, @id, 1987)
        where(Movies.Movie.Title, @id, @title)
        where(Movies.Movie.Director, @id, @did)
        where(Movies.Actor.Name, @did, @director)
      end
    end

    assert Neo.Repo.all(SomeFact) == [
             ["urn:movie:202", "Predator", "John McTiernan"],
             ["urn:movie:203", "Lethal Weapon", "Richard Donner"],
             ["urn:movie:204", "RoboCop", "Paul Verhoeven"]
           ]
  end
end
