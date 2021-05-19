module MrbRSpec
  class ChangeMatcher
    def initialize(value)
      @value = value
    end

    def compare(block)
      real_value = @value.call
      expected_value = @from
      MrbRSpec.assert_equal(real_value, expected_value)

      block.call

      real_value = @value.call
      expected_value = @to
      MrbRSpec.assert_equal(real_value, expected_value)
    end

    def compare_not(block)
      before_value = @value.call

      block.call

      after_value = @value.call

      MrbRSpec.assert_equal(before_value, after_value)
    end

    def from(value)
      @from = value
      self
    end

    def to(value)
      @to = value
      self
    end
  end
end
