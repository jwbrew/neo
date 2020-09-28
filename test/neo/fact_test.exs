defmodule SomeFact do
  use Neo.Fact, source: Neo.Event

  select [:id, :title, :director, :year] do
    where(Movies.Movie.Year, @id, @year)
    where(Movies.Movie.Title, @id, @title)
    where(Movies.Movie.Director, @id, @did)
    where(Movies.Actor.Name, @did, @director)
  end
end

defmodule Neo.FactTest do
  use ExUnit.Case

  test "succesfully queries a fact" do
    assert Neo.Repo.query(SomeFact) == [
             ["urn:movie:200", "The Terminator", "James Cameron", 1984],
             ["urn:movie:201", "First Blood", "Ted Kotcheff", 1982],
             ["urn:movie:202", "Predator", "John McTiernan", 1987],
             ["urn:movie:203", "Lethal Weapon", "Richard Donner", 1987],
             ["urn:movie:204", "RoboCop", "Paul Verhoeven", 1987],
             ["urn:movie:205", "Commando", "Mark L. Lester", 1985],
             ["urn:movie:206", "Die Hard", "John McTiernan", 1988],
             ["urn:movie:207", "Terminator 2: Judgment Day", "James Cameron", 1991],
             ["urn:movie:208", "Terminator 3: Rise of the Machines", "Jonathan Mostow", 2003],
             ["urn:movie:209", "Rambo: First Blood Part II", "George P. Cosmatos", 1985],
             ["urn:movie:210", "Rambo III", "Peter MacDonald", 1988],
             ["urn:movie:211", "Predator 2", "Stephen Hopkins", 1990],
             ["urn:movie:212", "Lethal Weapon 2", "Richard Donner", 1989],
             ["urn:movie:213", "Lethal Weapon 3", "Richard Donner", 1992],
             ["urn:movie:214", "Alien", "Ridley Scott", 1979],
             ["urn:movie:215", "Aliens", "James Cameron", 1986],
             ["urn:movie:216", "Mad Max", "George Miller", 1979],
             ["urn:movie:217", "Mad Max 2", "George Miller", 1981],
             ["urn:movie:218", "Mad Max Beyond Thunderdome", "George Miller", 1985],
             ["urn:movie:218", "Mad Max Beyond Thunderdome", "George Ogilvie", 1985],
             ["urn:movie:219", "Braveheart", "Mel Gibson", 1995]
           ]
  end

  test "successfully constrains a fact" do
    assert Neo.Repo.query(SomeFact) == [
             ["urn:movie:202", "Predator", "John McTiernan"],
             ["urn:movie:203", "Lethal Weapon", "Richard Donner"],
             ["urn:movie:204", "RoboCop", "Paul Verhoeven"]
           ]
  end
end
