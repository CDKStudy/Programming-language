# Dekang Cao
require_relative '../../../../core/ruby/render/core/render'
class Transform
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def render(g)
    g.push_affine_transform
    g.apply_translation(@x, @y)
    untransformed_render(g)
    g.pop_affine_transform
  end

  def move(direction, amount)
    case direction
    when :left
      @x -= amount
    when :right
      @x += amount
    when :up
      @y += amount
    when :down
      @y -= amount
    else
      raise ArgumentError, "Invalid direction: #{direction}"
    end
  end

  def bounds

    b = untransformed_bounds
    transformed_min = Point2.new(b.min.x + @x, b.min.y + @y)
    transformed_max = Point2.new(b.max.x + @x, b.max.y + @y)
    BoundingBox.new(transformed_min, transformed_max)
  end

  private


  def untransformed_render(g)
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def untransformed_bounds
    raise NotImplementedError, "Subclasses must implement this method"
  end
end
