# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

require_relative 'color_transform'

class BezierCurve < ColorTransform
  attr_accessor :control_points

  def initialize(control_points, x: 0, y: 0, color: nil)
    super(x, y, color)
    @control_points = control_points
  end

  private

  def untransformed_render(g)
    g.draw_curve(@control_points)
  end
  def untransformed_bounds
    raise StandardError.new("not yet implemented")
  end
end




if __FILE__ == $0
  control_points = [
      Point2.new(-0.5, -0.5),
      Point2.new(0.0, +0.5),
      Point2.new(0.5, -0.5)
  ]
  app = RenderClient.new(BezierCurve.new(control_points))
  app.main_loop
end
