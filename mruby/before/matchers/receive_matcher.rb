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

      Stubbing.stub(object_to_stub, @method_name) do |*args|
        called << args
        nil
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
  end
end
