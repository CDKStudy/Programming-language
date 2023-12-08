# Dekang Cao

require_relative 'transform'

class ColorTransform < Transform
  attr_accessor :color

  def initialize(x, y, color)
    super(x, y)
    @color = color
  end

  def render(g)

    g.color = @color unless @color.nil?


    super
  end
end
