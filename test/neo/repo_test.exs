defmodule Neo.RepoTest do
  use ExUnit.Case

  defmodule User.FirstName do
    use Neo.Event
  end

  test "commits and retrieves an event" do
    event = %Neo.Event{
      entity: 42,
      attribute: User.FirstName,
      value: "John",
      op: true
    }

    {:ok, id} = Neo.Repo.commit(event)
    {:ok, retrieved} = Neo.Repo.get(id)
    assert retrieved == %{event | id: id}
  end

  test "increments an event ID" do
    event = %Neo.Event{
      entity: 42,
      attribute: User.FirstName,
      value: "John",
      op: true
    }

    {:ok, id_1} = Neo.Repo.commit(event)
    {:ok, id_2} = Neo.Repo.commit(event)
    refute id_1 == id_2
  end
end
