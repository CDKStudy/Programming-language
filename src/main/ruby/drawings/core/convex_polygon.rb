# Dekang Cao

require_relative 'color_transform'

class ConvexPolygon < ColorTransform

  def initialize(points, x: 0, y: 0, color: nil)
    super(x, y, color)
    @points = points
  end
  def get_untransformed_bounds
    untransformed_bounds
  end
  private


  def untransformed_render(g)
    g.draw_convex_polygon(@points)
  end


  def untransformed_bounds
    min_x, max_x = @points.minmax_by { |p| p.x }.map(&:x)
    min_y, max_y = @points.minmax_by { |p| p.y }.map(&:y)
    BoundingBox.new(Point2.new(min_x, min_y), Point2.new(max_x, max_y))
  end
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
