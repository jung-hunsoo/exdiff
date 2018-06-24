# Exdiff
Text difference library for Elixir

## Installation
Add `exdiff` to your `mix.exs` dependencies:
```elixir
def deps do
  [{:exdiff, "~> 0.1.3"}]
end
```

## Quick example
```elixir
> Exdiff.diff_to_html("abd", "abcd")
{1, "<div class='exdiff-eq'>ab</div><div class='exdiff-ins'>c</div><div class='exdiff-eq'>d</div>"}
```

## Usage
There are three classes wrapped with `div` tag.

- `exdiff-del`
- `exdiff-ins`
- `exdiff-eq`

## Test

`mix test`
