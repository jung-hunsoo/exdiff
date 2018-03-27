defmodule ExdiffTest do
  use ExUnit.Case, async: true

  doctest Exdiff

  describe "Exdff.diff_to_html/2" do
    test "may accept nil as a parameter" do
      assert Exdiff.diff_to_html(nil, "a") =~ "a"
      assert Exdiff.diff_to_html("a", nil) =~ "a"
      refute Exdiff.diff_to_html(nil, nil) == nil
    end
    
    test "compare and return diff with defalut separator /p tag." do
      assert Exdiff.diff_to_html("<p>abc</p>", "<p>abc</p><p>def</p>") =~ "exdiff-ins"
      assert Exdiff.diff_to_html("<p>abc</p><p>def</p>", "<p>abc</p>") =~ "exdiff-del"
      assert Exdiff.diff_to_html("<p>abc</p>", "<p>abc</p><p>def</p>") =~ "exdiff-eq"
    end
  end
end
