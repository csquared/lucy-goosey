require 'minitest/spec'
require 'lucy-goosey'

describe Lucy::Goosey do
  describe "::parse_options" do
    describe "combinatorial tests" do
      before do
        def tester(raw_string, result)
          case raw_string
          when /foo/ then result['foo'].must_equal 'bar'
          when /--n/ then result['n'].must_equal '1'
          when /tru/ then result['truth'].must_equal true
          when /a=b/ then result['a'].must_equal 'b'
          when /fudge/ then result['fudge'].must_equal 'cakes are good'
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
  end
end
