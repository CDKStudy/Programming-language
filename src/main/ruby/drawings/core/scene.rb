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


  def render(g)
    g.clear(@background_color)
    @components.each do |component|
      component.render(g)
    end
  end
  def bounds
    min_x = Float::INFINITY
    min_y = Float::INFINITY
    max_x = -Float::INFINITY
    max_y = -Float::INFINITY

    for component in @components
      bounds = component.get_untransformed_bounds
      new_min_x = bounds.min.x + component.x
      new_min_y = bounds.min.y + component.y
      new_max_x = bounds.max.x + component.x
      new_max_y = bounds.max.y + component.y

      min_x = [min_x, new_min_x].min
      min_y = [min_y, new_min_y].min
      max_x = [max_x, new_max_x].max
      max_y = [max_y, new_max_y].max
    end

    BoundingBox.new(Point2.new(min_x, min_y), Point2.new(max_x, max_y))
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
