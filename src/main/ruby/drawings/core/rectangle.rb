# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

class Rectangle
  attr_accessor :half_width, :half_height

  def initialize(half_width, half_height)
    @half_width = half_width
    @half_height = half_height
  end

  def render(g)
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
end



if __FILE__ == $0
  phi = 1.618
  half_height = 0.5
  half_width = phi*half_height
  app = RenderClient.new(Rectangle.new(half_width, half_height))
  app.main_loop
end
