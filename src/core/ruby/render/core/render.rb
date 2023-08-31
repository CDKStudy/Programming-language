require_relative 'point2'
require_relative 'bounding_box'
require_relative 'color'
require_relative 'font'

class RenderClient
  def initialize(root, title: nil, width: 640, height: 480, clear_color: Color::BLACK, grid_line_color: nil)
    require_relative '../opengl/glfw_implementation'
    @impl = GlfwImplementation.new(root, title, width, height, clear_color, grid_line_color)
  end

  def main_loop
    @impl.main_loop
  end
end