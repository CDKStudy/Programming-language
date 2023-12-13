require_relative '../teleporting_turtle/core/teleporting_turtle'

# Dekang Cao
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

  def branch(teleporting_turtle, length, line_width_in_pixels, depth_remaining)
    if depth_remaining == 0
      teleporting_turtle.pen_color = @leaf_color
      teleporting_turtle.pen_width = line_width_in_pixels
      teleporting_turtle.forward(length)
    else
      next_length = length * 0.5
      next_line_width_in_pixels = line_width_in_pixels * 0.8

      teleporting_turtle.preserve_yield_restore do
        teleporting_turtle.forward(2 *length / 3.0)
        teleporting_turtle.right(30)
        branch(teleporting_turtle, next_length, next_line_width_in_pixels, depth_remaining - 1)
      end

      teleporting_turtle.preserve_yield_restore do
        teleporting_turtle.forward( length / 3.0)
        teleporting_turtle.right(-30)
        branch(teleporting_turtle, next_length, next_line_width_in_pixels, depth_remaining - 1)
      end

      teleporting_turtle.pen_color = @wood_color
      teleporting_turtle.pen_width = line_width_in_pixels
      teleporting_turtle.forward(length)
    end
  end
end

if __FILE__ == $0
  app = RenderClient.new(Branch.new, clear_color: Color::WHITE)
  app.main_loop
end
