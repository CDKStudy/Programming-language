# Dekang Cao

require_relative 'transform'
require_relative 'composite'
class CompositeTransform < Transform
  include Composite

  attr_reader :components

  def initialize(x: 0, y: 0)

    super(x, y)
    initialize_components
    @components = []
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
