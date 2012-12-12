require 'minitest/spec'
require 'lucy-goosey'

describe Lucy::Goosey do
  describe "::parse_options" do

    describe "simple cases" do
      it "returns empty hash with empty array" do
        result = Lucy::Goosey.parse_options([])
        result.must_equal({})
      end

      it "understands -n" do
        result = Lucy::Goosey.parse_options(%w(-n))
        result.must_equal({'n' => true})
      end

      it "understands -n is the best" do
        result = Lucy::Goosey.parse_options(%w(-n is the best))
        result.must_equal({'n' => 'is the best'})
      end

      it "understands -n 1" do
        result = Lucy::Goosey.parse_options(%w(-n 1))
        result.must_equal({'n' => '1'})
      end

      it "understands --n" do
        result = Lucy::Goosey.parse_options(%w(--n))
        result.must_equal({'n' => true})
      end

      it "understands --n 1" do
        result = Lucy::Goosey.parse_options(%w(--n 1))
        result.must_equal({'n' => '1'})
      end

      it "understands n=1" do
        result = Lucy::Goosey.parse_options(%w(n=1))
        result.must_equal({'n' => '1'})
      end
    end


    describe "bad input" do
      it "expects an array" do
        assert_raises ArgumentError do
          Lucy::Goosey.parse_options('')
        end
      end

      it "is ok with only leading words" do
        result = Lucy::Goosey.parse_options(%w(wtf bbq))
        result.must_equal({})
      end
    end

    describe "edge cases" do
      it "lets you use lots of words" do
        result = Lucy::Goosey.parse_options(%w(wtf bbq --foo bar none --foo-baz -n 1 -t))
        result.must_equal({'foo' => 'bar none', 'foo-baz' => true, 't' => true, 'n' => '1'})

        result = Lucy::Goosey.parse_options(%w(wtf bbq -foo bar none --foo-baz -n 1 -t))
        result.must_equal({'foo' => 'bar none', 'foo-baz' => true, 't' => true, 'n' => '1'})
      end

      it "ignores leading words" do
        result = Lucy::Goosey.parse_options(%w(wtf bbq --bar foo=baz --baz=bar -n 1 --bap))
        result.must_equal({ 'foo' => 'baz', 'baz' => 'bar', 'bar' => true, 'n' => '1', 'bap' => true })
      end

      it "works in any order" do
        result = Lucy::Goosey.parse_options(%w(--bar foo=baz --baz=bar bob=true --bap))
        result.must_equal({ 'foo' => 'baz', 'baz' => 'bar', 'bar' => true, 'bob' => 'true', 'bap' => true })
      end

      it "understands foo=bar and --baz=bar on the same line" do
        result = Lucy::Goosey.parse_options(%w(foo=baz --baz=bar bob=true --bar))
        result.must_equal({ 'foo' => 'baz', 'baz' => 'bar', 'bar' => true, 'bob' => 'true' })
      end
    end
  end
end
