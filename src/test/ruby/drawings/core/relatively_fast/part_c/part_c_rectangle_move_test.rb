require_relative '../../../util/transform_move_test_mixin'
require_relative '../../../../../../main/ruby/drawings/core/transform'
require_relative '../../../../../../main/ruby/drawings/core/color_transform'
require_relative '../../../../../../main/ruby/drawings/core/rectangle'

class RectangleMoveTest < Test::Unit::TestCase
  include TransformMoveTestMixin

  private

  def create_transform(initial_x, initial_y)
    rect = Rectangle.new(2,3, x: initial_x, y: initial_y)
    assert_equal(initial_x, rect.x)
    assert_equal(initial_y, rect.y)
    rect
  end
end