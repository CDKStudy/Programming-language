# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

require_relative 'color_transform'

class EquilateralTriangle < ColorTransform
  attr_accessor :half_side_length

  def initialize(half_side_length, x: 0, y: 0, color: nil)
    super(x, y, color)
    @half_side_length = half_side_length
  end

  private

  def untransformed_render(g)
    height = @half_side_length * Math.sqrt(3)

    ax = -@half_side_length
    ay = -height / 3

    bx = @half_side_length
    by = -height / 3

    cx = 0
    cy = height * 2 / 3

    g.draw_convex_polygon([Point2.new(ax, ay), Point2.new(bx, by), Point2.new(cx, cy)])
  end
  def untransformed_bounds
    height = @half_side_length * Math.sqrt(3)
    BoundingBox.new(
      Point2.new(-@half_side_length, -height / 3),
      Point2.new(@half_side_length, 2 * height / 3)
    )
  end
end


if __FILE__ == $0
  half_side_length = 0.5
  app = RenderClient.new(EquilateralTriangle.new(half_side_length))
  app.main_loop
end
