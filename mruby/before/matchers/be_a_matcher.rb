module MrbRSpec
  class BeAMatcher
    def initialize(value)
      @value = value
    end

    def compare(value)
      MrbRSpec.assert(
        value.is_a?(@value),
        "Expected #{value} to be a #{@value}"
      )
    end
  end
end
