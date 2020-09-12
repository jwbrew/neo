defmodule Neo.EventTest do
  use ExUnit.Case

  defmodule User.FirstName do
    use Neo.Event
  end

  test "generates an add event" do
    event =
      "John"
      |> User.FirstName.add(42)

    assert event == %Neo.Event{
             id: nil,
             entity: 42,
             attribute: User.FirstName,
             value: "John",
             op: true
           }
  end

  test "generates a retract event" do
    event =
      "John"
      |> User.FirstName.retract(42)

    assert event == %Neo.Event{
             id: nil,
             entity: 42,
             attribute: User.FirstName,
             value: "John",
             op: false
           }
  end
end
