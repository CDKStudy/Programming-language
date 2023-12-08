# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

require_relative 'color_transform'

class CircularSegment < ColorTransform
  attr_accessor :x_radius, :y_radius, :theta_a, :theta_z

  def initialize(x_radius, y_radius, theta_a, theta_z, x: 0, y: 0, color: nil)
    super(x, y, color)
    @x_radius = x_radius
    @y_radius = y_radius
    @theta_a = theta_a
    @theta_z = theta_z
  end

  private

  def untransformed_render(g)
    slice_count = 32
    delta_theta = (@theta_z - @theta_a) / slice_count
    points = []

    points << Point2.new(@x_radius * Math.cos(@theta_a), @y_radius * Math.sin(@theta_a))

    (slice_count + 1).times do |i|
      theta = @theta_a + (i * delta_theta)
      x = @x_radius * Math.cos(theta)
      y = @y_radius * Math.sin(theta)
      points << Point2.new(x, y)
    end

    points << Point2.new(@x_radius * Math.cos(@theta_z), @y_radius * Math.sin(@theta_z))

    g.draw_convex_polygon(points)
  end
  def untransformed_bounds
    raise StandardError.new("not yet implemented")
  end
end



if __FILE__ == $0
  x_radius = 0.6
  y_radius = 0.8
  theta_a = Math::PI / 4
  theta_z = (3 * Math::PI) / 4
  app = RenderClient.new(CircularSegment.new(x_radius, y_radius, theta_a, theta_z))
  app.main_loop
end
