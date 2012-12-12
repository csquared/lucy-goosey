require 'minitest/spec'
require 'minitest/autorun'

require 'lucy-goosey'

describe Lucy::Goosey do
  describe "::parse_options" do
    it "works in any order" do
      result = Lucy::Goosey.parse_options(%w(--bar foo=baz --baz=bar bob=true --bap))
      result.must_equal({ 'foo' => 'baz', 'baz' => 'bar', 'bar' => true, 'bob' => true, 'bap' => true })
    end

    it "understands foo=bar and --baz=bar on the same line" do
      result = Lucy::Goosey.parse_options(%w(foo=baz --baz=bar bob=true --bar))
      result.must_equal({ 'foo' => 'baz', 'baz' => 'bar', 'bar' => true, 'bob' => true })
    end
  end
end
