# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

class CircularSegment
end



if __FILE__ == $0
  x_radius = 0.6
  y_radius = 0.8
  theta_a = Math::PI / 4
  theta_z = (3 * Math::PI) / 4
  app = RenderClient.new(CircularSegment.new(x_radius, y_radius, theta_a, theta_z))
  app.main_loop
end
