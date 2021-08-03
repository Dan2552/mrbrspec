module MrbRSpec
  class AssertionFailure < StandardError; end

  def self.assert(bool, reason)
    return if bool
    raise AssertionFailure.new(reason)
  end

  def self.refute(bool, reason)
    return unless bool
    raise AssertionFailure.new(reason)
  end

  def self.assert_equal(a, b)
    assert(
      a == b,
      "Expected #{a.inspect} to be equal to #{b.inspect} (#{a.inspect} == #{b.inspect})"
    )
  end

  def self.refute_equal(a, b)
    refute(
      a == b,
      "Expected #{a.inspect} to not be equal to #{b.inspect} (#{a.inspect} == #{b.inspect})"
    )
  end

  def self.assert_includes(array, value)
    assert(
      array.include?(value),
      "Expected #{value.inspect} to be included in #{array.inspect}"
    )
  end

  def self.refute_includes(array, value)
    refute(
      array.include?(value),
      "Expected #{value.inspect} to not be included in #{array.inspect}"
    )
  end

  def self.assert_less_than(lhs, rhs)
    assert(
      lhs < rhs,
      "Expected #{lhs.inspect} to be less than #{rhs.inspect} (#{lhs.inspect} < #{rhs.inspect})"
    )
  end

  def self.assert_more_than(lhs, rhs)
    assert(
      lhs > rhs,
      "Expected #{lhs} to be less than #{rhs} (#{lhs} > #{rhs})"
    )
  end
end
