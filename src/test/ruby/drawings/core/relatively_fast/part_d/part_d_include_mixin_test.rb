require "test/unit"

require_relative '../../../../../../main/ruby/drawings/core/composite'
require_relative '../../../../../../main/ruby/drawings/core/scene'
require_relative '../../../../../../main/ruby/drawings/core/composite_transform'

class PartDIncludeMixinTest < Test::Unit::TestCase
  def test_mixes_in_composite
    [Scene, CompositeTransform].each do |cls|
      assert_include(cls.included_modules, Composite)
    end
  end
end



