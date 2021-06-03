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
      MrbRSpec.assert(false, "Expected to raise error, but did not (expected #{@value})")
    rescue Exception => e
      raise e if e.is_a?(MrbRSpec::AssertionFailure)

      if @value.class == Class
        MrbRSpec.assert_equal(e.class, @value)
      else
        MrbRSpec.assert_equal(e.class, @value.class)
      end

      if @value.respond_to?(:message)
        MrbRSpec.assert_equal(e.message, @value.message)
      end
    end

    def compare_not(value)
      value.call
    rescue Exception => e
      MrbRSpec.assert(false, "Expected to not raise an error, but did: #{e}\n#{e.backtrace.join("\n")}")
    end
  end
end
