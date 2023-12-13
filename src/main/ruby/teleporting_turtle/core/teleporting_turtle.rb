require_relative '../../../../core/ruby/turtle/core/turtle'

class TeleportingTurtle < Turtle
  def initialize(g, pen_width: 0.005, pen_color: Color::WHITE)
    super
    @pen_width_stack = []
    @pen_color_stack = []
  end

  def preserve_yield_restore
    preserve_state
    yield
    restore_state
  end

  private

  def preserve_state
    @pen_width_stack.push(pen_width)
    @pen_color_stack.push(pen_color)
    @g.push_affine_transform
  end

  def restore_state
    @g.pop_affine_transform
    # note self. required to invoke pen_color and pen_width methods as opposed to adding local variables
    self.pen_color = @pen_color_stack.pop
    self.pen_width = @pen_width_stack.pop
  end
end
