defmodule Exdiff do
  @moduledoc """
    Exdiff is a simple wrapper to make String.myers_difference/2 useful.
  """
  
  def diff_to_html(string1, string2, separator \\ "") do
    string1 = string1 || ""
    string2 = string2 || ""
    s1 = string1 |> String.split(separator, trim: true) |> Enum.map(fn(x) -> x <> separator end)
    s2 = string2 |> String.split(separator, trim: true) |> Enum.map(fn(x) -> x <> separator end)
    lmd = List.myers_difference(s1, s2)
    html = lmd |> wrap_html()
    diffs_count = lmd
      |> Keyword.delete(:eq)
      |> Enum.map(fn({k, v}) -> {k, String.length(Enum.join(v))} end)
      |> Enum.map_reduce([],
        fn({key, val}, acc) ->
          {{key, val}, Keyword.update(acc, key, val, &(&1 + val))}
        end)
      |> elem(1)
    diff_count = Keyword.get(diffs_count, :ins, 0) - Keyword.get(diffs_count, :del, 0)
    {diff_count, html}
  end
  
  defp wrap_html(lmd) do
    lmd
    |> Enum.map_join(fn {k, v} ->
      case k do
        :del -> "<div class='exdiff-del'>#{v}</div>"
        :ins -> "<div class='exdiff-ins'>#{v}</div>"
        _    -> "<div class='exdiff-eq'>#{v}</div>"
      end
    end)
  end
end
