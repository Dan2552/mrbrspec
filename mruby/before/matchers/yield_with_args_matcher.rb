module MrbRSpec
  class YieldWithArgsMatcher
    def initialize(args)
      @args = args
    end

    def compare(value)
      validator_is_called = false

      validator = Proc.new do |*args|
        validator_is_called = true

        @args.each.with_index do |lhs, index|
          rhs = args[index]
          MrbRSpec.assert_equal(lhs, rhs)
        end
      end

      value.call(validator)

      MrbRSpec.assert_equal(validator_is_called, true)
    rescue
      compare(value)
    end
  end
end
