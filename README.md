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

> Exdiff.diff_to_html("abd", "abcd", wrapper_tag: "span")
{1, "<span class='exdiff-eq'>ab</span><span class='exdiff-ins'>c</span><span class='exdiff-eq'>d</span>"}
```

## Usage

There are three HTML classes wrapped with tag.

- `exdiff-del`
- `exdiff-ins`
- `exdiff-eq`

## Test

`mix test`
