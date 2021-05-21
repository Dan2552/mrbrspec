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

    def compare_not(value)
      value.call
    rescue Exception => e
      MrbRSpec.assert(false, "Expected to not raise an error, but did: #{e}\n#{e.backtrace.join("\n")}")
    end
  end
end
