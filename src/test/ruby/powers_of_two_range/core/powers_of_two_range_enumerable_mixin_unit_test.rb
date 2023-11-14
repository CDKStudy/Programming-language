require "test/unit"

require_relative '../../../../main/ruby/powers_of_two_range/core/powers_of_two_range'

class PowersOfTwoRangeEnumerableRangeUnitTest < Test::Unit::TestCase
  def test_map
    actual = PowersOfTwoRange.new(71).map do |value|
      "*** #{value} ***"
    end
    assert_equal(["*** 1 ***", "*** 2 ***", "*** 4 ***", "*** 8 ***", "*** 16 ***", "*** 32 ***", "*** 64 ***"], actual)
  end

  def test_select
    actual = PowersOfTwoRange.new(71).select do |value|
      # is perfect square
      square_root = Math.sqrt(value)
      square_root == square_root.to_i
    end
    assert_equal([1, 4, 16, 64], actual)
  end
end

