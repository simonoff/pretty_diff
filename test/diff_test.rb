require File.dirname(__FILE__) + '/helper'
require 'cgi'

class DiffTest < Test::Unit::TestCase
  context "Pretty Diff" do

    setup do
      @small_diff = PrettyDiff::Diff.new read_diff('first.diff')
      @big_diff   = PrettyDiff::Diff.new read_diff('second.diff')
    end

    should "generate correct amount of chunks for each diff" do
      assert_equal 2, @small_diff.send(:chunks).size
      assert_equal 4, @big_diff.send(:chunks).size
    end

    should "generate HTML representation without errors" do
      assert @small_diff.to_html
      assert @big_diff.to_html
    end

    should "escape HTML from the input string" do
      text = "<b>Funky HTML</b>"
      diff = PrettyDiff::Diff.new(text)
      assert_equal "&lt;b&gt;Funky HTML&lt;/b&gt;", diff.input
    end

  end
end
