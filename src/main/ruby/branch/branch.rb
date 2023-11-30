require_relative '../teleporting_turtle/core/teleporting_turtle'

# __STUDENT_NAME__
# Dennis Cosgrove

class Branch
  def initialize(length: 1.4, line_width: 0.01, max_depth: 3, wood_color: Color::CARMINE, leaf_color: Color::JEEPERS_CREEPERS)
    super()
    @length = length
    @line_width = line_width
    @max_depth = max_depth

    @wood_color = wood_color
    @leaf_color = leaf_color
  end

  def render(g)
    g.apply_translation(-0.9, 0.0)
    g.apply_rotation(-90)

    glaring_color = Color::MAGENTA
    teleporting_turtle = TeleportingTurtle.new(g, pen_color: glaring_color)
    branch(teleporting_turtle, @length, @line_width, @max_depth)
  end

  private

  def branch(teleporting_turtle, length, line_width, depth_remaining)
    
    raise "not_yet_implemented"
  end
end

if __FILE__ == $0
  app = RenderClient.new(Branch.new, clear_color: Color::WHITE)
  app.main_loop
end
