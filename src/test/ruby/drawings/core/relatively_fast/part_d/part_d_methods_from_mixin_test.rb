require "test/unit"

require_relative '../../../util/require_all_but_composite'

class PartDMethodsFromMixinTest < Test::Unit::TestCase
  def test_mixin
    [:push_component].each do |method_name|
      handle_method(method_name, :public_method_defined?)
    end
    [:initialize_components, :untransformed_render, :untransformed_bounds].each do |method_name|
      handle_method(method_name, :private_method_defined?)
    end
  end

  private

  def handle_method(method_name, method_defined_name)
    [Composite, CompositeTransform, Scene].each do |module_or_class|
      assert(module_or_class.send(method_defined_name, method_name), "#{module_or_class} does not have a #{method_defined_name} #{method_name}")
    end
    [CompositeTransform, Scene].each do |cls|
      method = cls.instance_method(method_name)
      assert_equal(Composite, method.owner, "method #{method_name} on class #{cls} expected to be mixed in from Composite")
    end
  end
end
