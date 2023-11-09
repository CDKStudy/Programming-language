# __STUDENT_NAME__

require_relative '../../../../core/ruby/render/core/render'

class Ellipse
end



if __FILE__==$0
  x_radius = 0.3
  y_radius = 0.4
  app = RenderClient.new(Ellipse.new(x_radius, y_radius))
  app.main_loop
end
