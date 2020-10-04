# Neo

## TL;DR

Neo does three things;

- Provides a single, schema-less data model
- Historic data queries

## Motivation

> When the Matrix was first built, there was a man born inside who had the ability to change whatever he wanted, to remake the Matrix as he saw fit.

Let me start by framing the problem.

As developers, there's a whole class of software that fundamentally "organises the world".

What I mean by this is that our job - as a software industry - is to turn the "things that
people do" into some sort of helpful user interface. Be that managing your shopping list,
tracking your calorie intake, messaging each other, or whatever.

At the end of the day though, what we're really doing is taking this squishy, grey, crazy
world, and mapping it onto something that rigid and defined like a database schema. We represent
actions with API calls - be they CRUD operations, GraphQL mutations or whatever - that
take some part of this data model and change it, in response to a thing that happes.
Inevitably, this comes with a loss of signal; derived properties based on input values,
update database operations replacing old values etc.

Now for v1 of any project, that works great. You're 100% confident that your data model is
a true and accurate representation of the domain that your app operates in. Your mutations
are thoughtful, and and data you discard in the process is appropriate.

Then comes v2.

The world has changed. Your users want to use your product in a different way and your data
model is no longer a true and accurate representation of this domain.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `neo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:neo, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/neo](https://hexdocs.pm/neo).
