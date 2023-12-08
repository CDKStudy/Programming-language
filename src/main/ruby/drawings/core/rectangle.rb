# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

require_relative 'color_transform'

class Rectangle < ColorTransform
  attr_accessor :half_width, :half_height

  def initialize(half_width, half_height, x: 0, y: 0, color: nil)
    super(x, y, color)
    @half_width = half_width
    @half_height = half_height
  end
  def get_untransformed_bounds
    untransformed_bounds
  end
  private


  def untransformed_render(g)
    width = @half_width * 2
    height = @half_height * 2

    a_x = -@half_width
    a_y = -@half_height

    b_x = @half_width
    b_y = -@half_height

    c_x = @half_width
    c_y = @half_height

    d_x = -@half_width
    d_y = @half_height

    g.draw_convex_polygon([
      Point2.new(a_x, a_y),
      Point2.new(b_x, b_y),
      Point2.new(c_x, c_y),
      Point2.new(d_x, d_y)
    ])
  end
  def untransformed_bounds
    min_x = -@half_width
    min_y = -@half_height
    max_x = @half_width
    max_y = @half_height

    BoundingBox.new(Point2.new(min_x, min_y), Point2.new(max_x, max_y))
  end
end



if __FILE__ == $0
  phi = 1.618
  half_height = 0.5
  half_width = phi*half_height
  app = RenderClient.new(Rectangle.new(half_width, half_height))
  app.main_loop
end
