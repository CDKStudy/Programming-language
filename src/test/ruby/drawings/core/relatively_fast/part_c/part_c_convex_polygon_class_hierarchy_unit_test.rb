require "test/unit"

require_relative '../../../../../../main/ruby/drawings/core/convex_polygon'

class PartCConvexPolygonClassHierarchyUnitTest < Test::Unit::TestCase
  def test_class_hierarchy
    assert(ConvexPolygon.superclass == ColorTransform)
  end
end
