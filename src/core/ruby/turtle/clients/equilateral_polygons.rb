require_relative '../core/turtle'

class EquilateralPolygons
  def render(g)
    turtle = Turtle.new(g)
    turtle.pen_color = Color::HONOLULU_BLUE
    triangle(turtle)

    turtle.right(90)

    turtle.pen_width /= 2
    turtle.pen_color = Color::PARIS_DAISY
    square(turtle)

    turtle.right(135)

    turtle.pen_color = Color::FRENCH_VIOLET
    pentagon(turtle)
  end

  private

  def triangle(turtle)
    polygon(turtle, 3)
  end

  def square(turtle)
    polygon(turtle, 4)
  end

  def pentagon(turtle)
    polygon(turtle, 5)
  end

  def polygon(turtle, n)
    turtle.pen_width = 0.03
    n.times do
      turtle.forward 0.5
      turtle.right 360/n
      turtle.pen_width /= 2
    end
  end
end

if __FILE__ == $0
  app = RenderClient.new(EquilateralPolygons.new)
  app.main_loop
end
