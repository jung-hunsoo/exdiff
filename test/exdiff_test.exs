defmodule ExdiffTest do
  use ExUnit.Case, async: true

  doctest Exdiff

  describe "Exdff.diff_to_html/2" do
    test "may accept nil as a parameter" do
      assert Exdiff.diff_to_html(nil, "a") == {1, "<div class='exdiff-ins'>a</div>"}
      assert Exdiff.diff_to_html("a", nil) == {-1, "<div class='exdiff-del'>a</div>"}
      assert Exdiff.diff_to_html(nil, nil) == {0, ""}
    end
    
    test "compare and return diff with defalut separator /p tag." do
      str_a = "<p>abc</p>"
      str_b = "<p>abc</p><p>def</p>"
      diff_count = String.length(str_b) - String.length(str_a)
      assert Exdiff.diff_to_html(str_a, str_b, "</p>") == {diff_count, "<div class='exdiff-eq'><p>abc</p></div><div class='exdiff-ins'><p>def</p></div>"}
      assert Exdiff.diff_to_html(str_b, str_a, "</p>") == {-diff_count, "<div class='exdiff-eq'><p>abc</p></div><div class='exdiff-del'><p>def</p></div>"}
      assert Exdiff.diff_to_html(str_a, str_a, "</p>") == {0, "<div class='exdiff-eq'><p>abc</p></div>"}
    end
  end
end
