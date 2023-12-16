# Dekang Cao

module Composite

  def push_component(component)
    @components << component
  end
  private
  def initialize_components
    @components = []
  end
  def untransformed_render(g)
    @components.each { |component| component.render(g) }
  end


  def untransformed_bounds
    min_x = Float::INFINITY
    min_y = Float::INFINITY
    max_x = -Float::INFINITY
    max_y = -Float::INFINITY

    for component in @components
      bounds = component.get_untransformed_bounds
      new_min_x = bounds.min.x + component.x
      new_min_y = bounds.min.y + component.y
      new_max_x = bounds.max.x + component.x
      new_max_y = bounds.max.y + component.y

      min_x = [min_x, new_min_x].min
      min_y = [min_y, new_min_y].min
      max_x = [max_x, new_max_x].max
      max_y = [max_y, new_max_y].max
    end

    BoundingBox.new(Point2.new(min_x, min_y), Point2.new(max_x, max_y))
  end
end
