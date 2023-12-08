# Dekang Cao

module Composite
  # Ensure this method is private

  def initialize_components
    @components = []
  end

  # Method to add a component to the composite
  def push_component(component)
    @components << component
  end
  private
  def untransformed_render(g)
    @components.each { |component| component.render(g) }
  end
  # This method should be implemented by including classes
  def untransformed_render
    raise NotImplementedError, 'untransformed_render must be implemented'
  end

  # This method should be implemented by including classes
  def untransformed_bounds
    raise NotImplementedError, 'untransformed_bounds must be implemented'
  end
end
