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

    describe "combinatorial tests" do
      before do
        def tester(raw_string, result)
          case raw_string
          when /foo/ then result['foo'].must_equal 'bar'
          when /--n/ then result['n'].must_equal '1'
          when /tru/ then result['truth'].must_equal true
          when /a=b/ then result['a'].must_equal 'b'
          end
        end
      end

      first_level = ['-foo bar', '--n 1', '--truth', 'a=b', '-f']

      first_level.each do |first|
        second_level = first_level - [first]
        second_level.each do |second|
          test_string = "#{first} #{second}"
          # two levels deep
          it "understands #{test_string}" do
            result = Lucy::Goosey.parse_options(test_string.split(' '))
            tester(first, result)
            tester(second, result)
          end

          # third level - its getting a little crazy in here
          third_level = second_level - [second]
          third_level.each do |third|
            test_string = "#{first} #{second} #{third}"

            it "understands #{test_string}" do
              result = Lucy::Goosey.parse_options(test_string.split(' '))
              tester(first, result)
              tester(second, result)
              tester(third, result)
            end

            # fourth level - now we're having fun!
            fourth_level = third_level - [third]
            fourth_level.each do |fourth|
              test_string = "#{first} #{second} #{third} #{fourth}"

              it "understands #{test_string}" do
                result = Lucy::Goosey.parse_options(test_string.split(' '))
                tester(first, result)
                tester(second, result)
                tester(third, result)
                tester(fourth, result)
              end

              # fifth level - cus we're not fucking around
              fifth = (fourth_level - [fourth]).first
              test_string = "#{first} #{second} #{third} #{fourth} #{fifth}"

              it "understands #{test_string}" do
                result = Lucy::Goosey.parse_options(test_string.split(' '))
                tester(first, result)
                tester(second, result)
                tester(third, result)
                tester(fourth, result)
                tester(fifth, result)
              end
            end
          end
        end
      end
    end

    describe "bad input" do
      it "expects an array" do
        assert_raises ArgumentError do
          Lucy::Goosey.parse_options('')
        end
      end
    end

    describe "edge cases" do
      it "ignores leading words" do
        result = Lucy::Goosey.parse_options(%w(wtf bbq --bar foo=baz --baz=bar -n 1 --bap))
        result.must_equal({ 'foo' => 'baz', 'baz' => 'bar', 'bar' => true, 'n' => '1', 'bap' => true })
      end

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
end
