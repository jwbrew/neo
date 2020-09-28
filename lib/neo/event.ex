defmodule Neo.Event do
  @moduledoc """
  An incredibly lightweight way to define "something that happens" in the real world


  """
  @typedoc """
  This currently borrows heavily (exclusively?) from Datomic's data model
  https://docs.datomic.com/cloud/whatis/data-model.html
  """
  @type t :: %__MODULE__{
          id: non_neg_integer,
          entity: number | binary,
          attribute: binary,
          value: any,
          op: boolean
        }
  defstruct [:entity, :attribute, :value, op: true, id: nil]

  defmacro __using__(_) do
    quote do
      def add(entity, value) do
        %Neo.Event{entity: entity, attribute: __MODULE__, value: value}
      end

      def retract(entity, value) do
        %Neo.Event{entity: entity, attribute: __MODULE__, value: value, op: false}
      end
    end
  end
end
