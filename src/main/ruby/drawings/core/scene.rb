# __STUDENT_NAME__

require_relative '../../../core/ruby/render/core/render'

class Scene
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
