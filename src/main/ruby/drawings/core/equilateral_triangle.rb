# __STUDENT_NAME__

require_relative '../../../../core/ruby/render/core/render'

class EquilateralTriangle
end


if __FILE__ == $0
  half_side_length = 0.5
  app = RenderClient.new(EquilateralTriangle.new(half_side_length))
  app.main_loop
end
