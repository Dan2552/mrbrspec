module MrbRSpec
  class ReceiveMatcher
    def initialize(method_name, expectation)
      @method_name = method_name
      @expectation = expectation
      @args = []
    end

    def compare(object_to_stub)
      @object_to_stub = object_to_stub
      called = []
      @called = called
      return_value = @and_return

      Stubbing.stub(object_to_stub, @method_name) do |*args|
        called << args
        return_value
      end
    end

    def after
      MrbRSpec.assert(
        @called == [@args],
        "Expected #{@object_to_stub} to receive #{@method_name} with args: #{@args}"
      )
    end

    def with(*args)
      @args = args
      self
    end

    def and_return(return_value)
      @and_return = return_value
      self
    end
  end
end
