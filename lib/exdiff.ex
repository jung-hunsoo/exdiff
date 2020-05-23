defmodule Exdiff do
  @moduledoc """
    Exdiff is a simple wrapper to make String.myers_difference/2 useful.
  """

  def diff(string1, string2, opts \\ []) do
    separator = Keyword.get(opts, :separator, "")
    wrapper_tag = Keyword.get(opts, :wrapper_tag, "div")

    string1 = string1 || ""
    string2 = string2 || ""
    s1 = string1 |> String.split(separator, trim: true) |> Enum.map(fn(x) -> x <> separator end)
    s2 = string2 |> String.split(separator, trim: true) |> Enum.map(fn(x) -> x <> separator end)
    lmd = List.myers_difference(s1, s2)
    html = lmd |> wrap_html(wrapper_tag)
    diffs_count = lmd
      |> Keyword.delete(:eq)
      |> Enum.map(fn({k, v}) -> {k, String.length(Enum.join(v))} end)
      |> Enum.map_reduce([],
        fn({key, val}, acc) ->
          {{key, val}, Keyword.update(acc, key, val, &(&1 + val))}
        end)
      |> elem(1)
    diff_count = Keyword.get(diffs_count, :ins, 0) - Keyword.get(diffs_count, :del, 0)
    %{html: html, length: diff_count}
  end
  
  def diff_to_html(string1, string2, opts \\ []) do
    diff_map = diff(string1, string2, opts)
    {diff_map.length, diff_map.html}
  end
  
  defp wrap_html(lmd, wrapper_tag) do
    lmd
    |> Enum.map_join(fn {k, v} ->
      case k do
        :del -> "<#{wrapper_tag} class='exdiff-del'>#{v}</#{wrapper_tag}>"
        :ins -> "<#{wrapper_tag} class='exdiff-ins'>#{v}</#{wrapper_tag}>"
        _    -> "<#{wrapper_tag} class='exdiff-eq'>#{v}</#{wrapper_tag}>"
      end
    end)
  end
end
