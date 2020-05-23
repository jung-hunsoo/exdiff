defmodule ExdiffTest do
  use ExUnit.Case, async: true

  doctest Exdiff

  describe "Exdiff.diff/3" do
    test "accept nil as a parameter" do
      assert Exdiff.diff(nil, "a") == %{html: "<div class='exdiff-ins'>a</div>", length: 1}
      assert Exdiff.diff("a", nil) == %{html: "<div class='exdiff-del'>a</div>", length: -1}
      assert Exdiff.diff(nil, nil) == %{html: "", length: 0}
    end
    
    test "compare and return diff with a separator." do
      str_a = "<p>abc</p>"
      str_b = "<p>abc</p><p>def</p>"
      diff_count = String.length(str_b) - String.length(str_a)
      assert Exdiff.diff(str_a, str_b, separator: "</p>") == %{html: "<div class='exdiff-eq'><p>abc</p></div><div class='exdiff-ins'><p>def</p></div>", length: diff_count}
      assert Exdiff.diff(str_b, str_a, separator: "</p>") == %{html: "<div class='exdiff-eq'><p>abc</p></div><div class='exdiff-del'><p>def</p></div>", length: -diff_count}
      assert Exdiff.diff(str_a, str_a, separator: "</p>") == %{html: "<div class='exdiff-eq'><p>abc</p></div>", length: 0}
    end

    test "accepts a custom wrapper tag optionally" do
      str_a = "Hello Exdiff."
      str_b = "Hi Exdiff."
      diff_count = String.length(str_b) - String.length(str_a)
      assert Exdiff.diff(str_a, str_b, wrapper_tag: "span") ==
        %{html: "<span class='exdiff-eq'>H</span><span class='exdiff-del'>ello</span><span class='exdiff-ins'>i</span><span class='exdiff-eq'> Exdiff.</span>", length: diff_count}
    end
  end

  describe "Exdff.diff_to_html/2" do
    test "may accept nil as a parameter" do
      assert Exdiff.diff_to_html(nil, "a") == {1, "<div class='exdiff-ins'>a</div>"}
      assert Exdiff.diff_to_html("a", nil) == {-1, "<div class='exdiff-del'>a</div>"}
      assert Exdiff.diff_to_html(nil, nil) == {0, ""}
    end
    
    test "compare and return diff with a separator." do
      str_a = "<p>abc</p>"
      str_b = "<p>abc</p><p>def</p>"
      diff_count = String.length(str_b) - String.length(str_a)
      assert Exdiff.diff_to_html(str_a, str_b, separator: "</p>") == {diff_count, "<div class='exdiff-eq'><p>abc</p></div><div class='exdiff-ins'><p>def</p></div>"}
      assert Exdiff.diff_to_html(str_b, str_a, separator: "</p>") == {-diff_count, "<div class='exdiff-eq'><p>abc</p></div><div class='exdiff-del'><p>def</p></div>"}
      assert Exdiff.diff_to_html(str_a, str_a, separator: "</p>") == {0, "<div class='exdiff-eq'><p>abc</p></div>"}
    end

    test "accepts a custom wrapper tag optionally" do
      str_a = "Hello Exdiff."
      str_b = "Hi Exdiff."
      diff_count = String.length(str_b) - String.length(str_a)
      assert Exdiff.diff_to_html(str_a, str_b, wrapper_tag: "span") ==
        {diff_count, "<span class='exdiff-eq'>H</span><span class='exdiff-del'>ello</span><span class='exdiff-ins'>i</span><span class='exdiff-eq'> Exdiff.</span>"}
    end
  end
end
