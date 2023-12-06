# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

class Text
  attr_accessor :text, :font

  def initialize(text, font)
    @text = text
    @font = font
  end

  def render(g)
    g.draw_string(@text, @font, 0, 0)
  end
end



if __FILE__==$0
  text = "SML, Racket, and Ruby"
  app = RenderClient.new(Text.new(text, Font::TIMES_ROMAN_24))
  app.main_loop
end
