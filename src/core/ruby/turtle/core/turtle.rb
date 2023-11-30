require_relative '../../render/core/render'

class Turtle
  # https://el.media.mit.edu/logo-foundation/what_is_logo/logo_primer.html
  attr_accessor :pen_color, :pen_width

  def initialize(g, pen_width: 0.005, pen_color: Color::WHITE)
    super()
    @g = g
    @is_pen_down = true
    @pen_width = pen_width
    @pen_color = pen_color
  end

  def pen_up
    @is_pen_down = false
  end

  def pen_down
    @is_pen_down = true
  end

  def forward(amount)
    y = amount
    x = @pen_width
    if @is_pen_down
      @g.color = @pen_color
      points = [
        Point2.new(-x, 0.0),
        Point2.new(-x, y),
        Point2.new(x, y),
        Point2.new(x, 0.0)
      ]
      @g.draw_convex_polygon(points)
    end
    @g.apply_translation(0, y)
  end

  def right(degrees)
    @g.apply_rotation(-degrees)
  end
end
