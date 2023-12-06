# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

class BezierCurve
  attr_accessor :control_points

  def initialize(control_points)
    @control_points = control_points
  end

  def render(g)
    g.draw_curve(@control_points)
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
