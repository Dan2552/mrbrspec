class MrbRSpec::EqlMatcher
  def initialize(value)
    @value = value
  end

  def compare(value)
    MrbRSpec.assert(value.eql?(@value), "Expected #{value} to exactly #{@value} (lhs.equal?(rhs)")
  end
end
