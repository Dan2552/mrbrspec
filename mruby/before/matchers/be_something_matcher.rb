require 'irb'
module MrbRSpec
  class BeSomethingMatcher
    def initialize(meth)
      @comparison = :"#{meth.to_s.split("be_", 2).last}?"
    end

    def compare(value)
      MrbRSpec.assert(
        value.send(@comparison),
        "Expected #{value} to be #{@comparison}"
      )
    end
  end
end
