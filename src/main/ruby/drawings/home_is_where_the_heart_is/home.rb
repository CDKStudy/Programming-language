# Dekang Cao
# Dennis Cosgrove

require_relative '../core/rectangle'
require_relative '../core/equilateral_triangle'

class Home

end

if __FILE__ == $0
  app = RenderClient.new(Home.new)
  app.main_loop
end
