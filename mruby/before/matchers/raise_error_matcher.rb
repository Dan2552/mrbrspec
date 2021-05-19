module MrbRSpec
  class RaiseErrorMatcher
    def initialize(value)
      if value.is_a?(String)
        @value = RuntimeError.new(value)
      else
        @value = value
      end
    end

    def compare(value)
      value.call
    rescue Exception => e
      MrbRSpec.assert_equal(e.class, @value.class)
      MrbRSpec.assert_equal(e.message, @value.message)
    end
  end
end
