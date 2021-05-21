module MrbRSpec
  module Matchers
    def self.define(name, &blk)
      MrbRSpec::Expectation.define_method(name) do |value|
        CustomMatcher.new(blk, value)
      end
    end
  end
end
