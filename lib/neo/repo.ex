defmodule Neo.Repo do
  use Amnesia

  @moduledoc """
  Responsible for persisting and retrieving events from the mnesia datastore
  """

  defdatabase Database do
    deftable Event, [{:id, autoincrement}, :entity, :attribute, :value, :op],
      type: :ordered_set,
      index: [:entity, :attribute, :value, :op] do
      @type t :: Neo.Event.t()
    end
  end

  @spec commit(Neo.Event.t()) :: {:ok, non_neg_integer} | {:error, atom}
  def commit(%{id: id}) when not is_nil(id), do: {:error, :existing_event}

  def commit(event) do
    Amnesia.transaction do
      try do
        %{id: id} =
          event
          |> from_event()
          |> Database.Event.write!()

        {:ok, id}
      rescue
        error -> {:error, error}
      end
    end
  end

  @spec get(non_neg_integer) :: {:ok, Neo.Event.t()} | {:error, atom}
  def get(id) do
    Amnesia.transaction do
      try do
        event = Database.Event.read!(id)

        {:ok, to_event(event)}
      rescue
        error -> {error, :error}
      end
    end
  end

  defp from_event(event), do: %{event | __struct__: Database.Event}
  defp to_event(event), do: %{event | __struct__: Neo.Event}
end
