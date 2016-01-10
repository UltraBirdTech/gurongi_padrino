require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class Gurongi::App::GurongiHelperTest < Test::Unit::TestCase
  context "Gurongi::App::GurongiHelper" do
    setup do
      @helpers = Class.new
      @helpers.extend Gurongi::App::GurongiHelper
    end

    should "return nil" do
      assert_equal nil, @helpers.foo
    end
  end
end
