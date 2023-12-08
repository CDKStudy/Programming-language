# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

require_relative 'color_transform'

class Text < ColorTransform
  attr_accessor :text, :font

  def initialize(text, font, x: 0, y: 0, color: nil)
    super(x, y, color)
    @text = text
    @font = font
  end

  private

  def untransformed_render(g)
    g.draw_string(@text, @font, 0, 0)
  end
  def untransformed_bounds
    raise StandardError.new("not yet implemented")
  end
end



if __FILE__==$0
  text = "SML, Racket, and Ruby"
  app = RenderClient.new(Text.new(text, Font::TIMES_ROMAN_24))
  app.main_loop
end
