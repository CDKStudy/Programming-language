require_relative 'abstract_point2d'

class CartesianPoint2d < AbstractPoint2d
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end