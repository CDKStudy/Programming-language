# Dekang Cao

require_relative 'transform'
require_relative 'composite'
class CompositeTransform < Transform
  include Composite

  attr_reader :components

  def initialize(x: 0, y: 0)

    super(x, y)
    @components = []
  end


  def push_component(component)
    @components << component
  end

  def move(direction, amount)
    case direction
    when :left then @x -= amount
    when :right then @x += amount
    when :up then @y += amount
    when :down then @y -= amount
    else raise ArgumentError, "Invalid direction: #{direction}"
    end
  end


  private


  def untransformed_render(g)
    @components.each do |component|

      component.render(g)
    end
  end
  def untransformed_bounds

    min_x = Float::INFINITY
    min_y = Float::INFINITY
    max_x = -Float::INFINITY
    max_y = -Float::INFINITY

    @components.each do |component|
      component_bounds = component.get_untransformed_bounds
      transformed_min_x = component_bounds.min.x + component.x
      transformed_min_y = component_bounds.min.y + component.y
      transformed_max_x = component_bounds.max.x + component.x
      transformed_max_y = component_bounds.max.y + component.y

      min_x = [min_x, transformed_min_x].min
      min_y = [min_y, transformed_min_y].min
      max_x = [max_x, transformed_max_x].max
      max_y = [max_y, transformed_max_y].max
    end

    BoundingBox.new(Point2.new(min_x, min_y), Point2.new(max_x, max_y))
  end
end




if __FILE__ == $0
  require_relative 'equilateral_triangle'
  require_relative 'rectangle'
  class House < CompositeTransform
    def initialize(x: 0, y: 0)
      super
      push_component(Rectangle.new(0.2, 0.2, y: -0.3, color:Color::ALIZARAN_CRIMSON))
      push_component(EquilateralTriangle.new(0.25, color: Color::JEEPERS_CREEPERS))
    end
  end
  app = RenderClient.new(House.new)
  app.main_loop
end
