# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

require_relative 'color_transform'

class Ellipse < ColorTransform
  attr_accessor :x_radius, :y_radius


  def initialize(x_radius, y_radius, x: 0, y: 0, color: nil)
    super(x, y, color)
    @x_radius = x_radius
    @y_radius = y_radius
  end

  private


  def untransformed_render(g)
    slice_count = 32
    delta_theta = (2 * Math::PI) / slice_count
    points = []

    slice_count.times do |i|
      theta = i * delta_theta
      x = @x_radius * Math.cos(theta)
      y = @y_radius * Math.sin(theta)
      points << Point2.new(x, y)
    end

    points << points.first

    g.draw_convex_polygon(points)
  end
  def untransformed_bounds
    BoundingBox.new(
      Point2.new(-@x_radius, -@y_radius),
      Point2.new(@x_radius, @y_radius)
    )
  end
end




if __FILE__==$0
  x_radius = 0.3
  y_radius = 0.4
  app = RenderClient.new(Ellipse.new(x_radius, y_radius))
  app.main_loop
end
