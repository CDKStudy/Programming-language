# __STUDENT_NAME__

require_relative '../../../../core/ruby/render/core/render'

class Rectangle
end



if __FILE__ == $0
  phi = 1.618
  half_height = 0.5
  half_width = phi*half_height
  app = RenderClient.new(Rectangle.new(half_width, half_height))
  app.main_loop
end
