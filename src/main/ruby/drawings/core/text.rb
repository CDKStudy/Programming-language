# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

class Text
end



if __FILE__==$0
  text = "SML, Racket, and Ruby"
  app = RenderClient.new(Text.new(text, Font::TIMES_ROMAN_24))
  app.main_loop
end
