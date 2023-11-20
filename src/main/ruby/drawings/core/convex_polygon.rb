# __STUDENT_NAME__

require_relative 'color_transform'

class ConvexPolygon < ColorTransform

end

if __FILE__ == $0
  points = [
      Point2.new(0.85, 0.0),
      Point2.new(0.1, 0.25),
      Point2.new(0.0, 0.45),
      Point2.new(0.15, 0.7),
      Point2.new(0.65, 1.0),
      Point2.new(0.95, 0.95),
      Point2.new(1.1, 0.75)
  ]
  app = RenderClient.new(ConvexPolygon.new(points, x: -0.5, y: -0.5, color: Color.new(1, 0, 0)))
  app.main_loop
end
