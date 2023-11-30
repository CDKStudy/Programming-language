require_relative '../core/teleporting_turtle'

class PreserveYieldRestoreClient
  def render(g)
    teleporting_turtle = TeleportingTurtle.new(g)
    teleporting_turtle.pen_color = Color::DODGER_BLUE
    teleporting_turtle.pen_width = 0.02
    teleporting_turtle.forward(0.25)
    teleporting_turtle.preserve_yield_restore do
      teleporting_turtle.right(90)
      teleporting_turtle.pen_color = Color::OUTRAGEOUS_ORANGE
      teleporting_turtle.pen_width = 0.005
      45.times do
        teleporting_turtle.right(5)
        teleporting_turtle.forward(0.05)
      end
    end

    teleporting_turtle.forward(0.25)
  end
end

if __FILE__ == $0
  require_relative '../../../../core/ruby/render/core/render'
  app = RenderClient.new(PreserveYieldRestoreClient.new)
  app.main_loop
end