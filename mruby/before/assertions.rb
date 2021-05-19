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
      "Expected #{a} to be equal to #{b} (#{a} == #{b})"
    )
  end

  def self.refute_equal(a, b)
    refute(
      a == b,
      "Expected #{a} to not be equal to #{b} (#{a} == #{b})"
    )
  end

  def self.assert_includes(array, value)
    assert(
      array.include?(value),
      "Expected #{value} to be included in #{array}"
    )
  end
end
