# __STUDENT_NAME__

require_relative '../../../../core/ruby/render/core/render'

class BezierCurve
  # https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Quadratic_B%C3%A9zier_curves
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
