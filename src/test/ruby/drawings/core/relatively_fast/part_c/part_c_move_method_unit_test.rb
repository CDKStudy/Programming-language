require "test/unit"

require_relative '../../../util/require_all_but_composite'

class PartCMoveMethodUnitTest < Test::Unit::TestCase
  @@transformables = nil

  def test_move_left
    check_move(:left, -1, 0)
  end

  def test_move_right
    check_move(:right, 1, 0)
  end

  def test_move_up
    check_move(:up, 0, 1)
  end

  def test_move_down
    check_move(:down, 0, -1)
  end

  def test_move_argument_error
    transformables.each do |transformable|
      assert_raise(ArgumentError) { transformable.move(:invalid) }
    end
  end

  private

  def check_move(direction, x_direction, y_direction)
    amounts = [1.0, 2.0, 3.0, 10.0, 231.0, -425.0]
    transformables.each do |transformable|
      assert(transformable.public_method(:move))

      prev_x = transformable.x
      prev_y = transformable.y

      amounts.each do |amount|
        transformable.move(direction, amount)

        expected_x = prev_x + amount*x_direction
        expected_y = prev_y + amount*y_direction
        assert_equal(expected_x, transformable.x)
        assert_equal(expected_y, transformable.y)

        prev_x = expected_x
        prev_y = expected_y
      end
    end
  end

  def transformables
    if @@transformables.nil?
      @@transformables = [Rectangle.new(1, 1),
                          Ellipse.new(1, 1),
                          EquilateralTriangle.new(0.5),
                          CircularSegment.new(0.6, 0.8, Math::PI * 0.3, Math::PI),
                          BezierCurve.new([
                                            Point2.new(-0.5, -0.5),
                                            Point2.new(0.0, +0.5),
                                            Point2.new(0.5, -0.5)
                                          ]),
                          Text.new("Hello", Font::TIMES_ROMAN_24),
                          CircularSegment.new(0.6, 0.8, Math::PI * 0.3, Math::PI),
                          Image.new('https://www.cse.wustl.edu/~cosgroved/courses/cse425s/timeless/ruby/ruby/resources/dan128.png'),
                          CompositeTransform.new(),
                          ConvexPolygon.new([
                                              Point2.new(0.85, 0.0),
                                              Point2.new(0.1, 0.25),
                                              Point2.new(0.0, 0.45),
                                              Point2.new(0.15, 0.7),
                                              Point2.new(0.65, 1.0),
                                              Point2.new(0.95, 0.95),
                                              Point2.new(1.1, 0.75)
                                            ])
      ]
    end
    @@transformables
  end
end
