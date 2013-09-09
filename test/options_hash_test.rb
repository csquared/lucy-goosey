require 'minitest/spec'
require 'lucy-goosey'

describe Lucy::Goosey do
  describe "argv" do
    it "should equal the original array" do
      options = Lucy::Goosey.parse(['fe', 'fi', 'fo', 'fum'])
      assert_equal 'fe', options.argv[0]
      assert_equal 'fi', options.argv[1]
      assert_equal 'fo', options.argv[2]
      assert_equal 'fum', options.argv[3]
    end
  end

  describe 'help?' do
    it "should be true if -h is passed in" do
      options = Lucy::Goosey.parse(%w{fi -h fo fum})
      assert options.help?

      options = Lucy::Goosey.parse(%w{fi -hi fo fum})
      refute options.help?
    end

    it "should be true if --help is passed in" do
      options = Lucy::Goosey.parse(%w{fi --help fo fum})
      assert options.help?

      options = Lucy::Goosey.parse(%w{fi --halp fo fum})
      refute options.help?
    end

    it "should be true if 'help' is the first arg" do
      options = Lucy::Goosey.parse(%w{help me})
      assert options.help?

      options = Lucy::Goosey.parse(%w{me help you})
      refute options.help?
    end
  end
end
