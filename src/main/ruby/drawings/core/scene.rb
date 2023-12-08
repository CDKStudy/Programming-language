# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'
require_relative 'composite'
class Scene
  include Composite
  attr_accessor :background_color
  attr_reader :components

  def initialize(background_color: Color.new(0, 0, 0))
    @background_color = background_color
     initialize_components
  end

  def push_component(component)
    @components << component
  end

  def render(g)
    g.clear(@background_color)
    @components.each do |component|
      component.render(g)
    end
  end
  def bounds
    min_point = Point2.new(Float::INFINITY, Float::INFINITY)
    max_point = Point2.new(-Float::INFINITY, -Float::INFINITY)

    @components.each do |component|
      comp_bounds = component.bounds
      min_point.x = [min_point.x, comp_bounds.min.x].min
      min_point.y = [min_point.y, comp_bounds.min.y].min
      max_point.x = [max_point.x, comp_bounds.max.x].max
      max_point.y = [max_point.y, comp_bounds.max.y].max
    end

    BoundingBox.new(min_point, max_point)
  end
end



if __FILE__ == $0
  require_relative 'equilateral_triangle'
  require_relative 'rectangle'
  require_relative 'composite_transform'
  class House < CompositeTransform
    def initialize(x: 0, y: 0)
      super
      push_component(Rectangle.new(0.2, 0.2, y: -0.3, color:Color::ALIZARAN_CRIMSON))
      push_component(EquilateralTriangle.new(0.25, color: Color::JEEPERS_CREEPERS))
    end
  end

  scene = Scene.new(background_color: Color::HONOLULU_BLUE)
  scene.push_component(House.new(x: -0.4, y: 0.5))
  scene.push_component(House.new(x: +0.2, y: -0.2))
  app = RenderClient.new(scene, clear_color: Color::OUTRAGEOUS_ORANGE)
  app.main_loop
end
