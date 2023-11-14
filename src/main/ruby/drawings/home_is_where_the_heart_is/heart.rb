# Dekang Cao
# Dennis Cosgrove

require_relative '../core/rectangle'
require_relative '../core/ellipse'

class Heart
  
end

if __FILE__ == $0
  app = RenderClient.new(Heart.new)
  app.main_loop
end
