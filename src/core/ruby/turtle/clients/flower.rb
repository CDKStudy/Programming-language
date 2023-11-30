require_relative '../core/turtle'

class Flower
  def render(g)
    flower(Turtle.new(g))
  end

  private

  def square(turtle)
    4.times do
      turtle.forward 0.5
      turtle.right 90
    end
  end

  def flower(turtle)
    36.times do
      turtle.right 10
      square(turtle)
    end
  end
end

if __FILE__ == $0
  app = RenderClient.new(Flower.new)
  app.main_loop
end
