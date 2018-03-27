# Exdiff
Text difference library for Elixir

## Installation
Add `exdiff` to your `mix.exs` dependencies:
```elixir
def deps do
  [{:exdiff, "~> 0.1.1"}]
end
```

## Quick example
```elixir
Exdiff.diff_to_html(original, target)
```

## Usage
There are three classes wrapped with `div` tag.

- `exdiff-del`
- `exdiff-ins`
- `exdiff-eq`

## Test

`mix test`
