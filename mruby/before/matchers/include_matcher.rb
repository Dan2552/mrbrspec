module MrbRSpec
  class IncludeMatcher
    def initialize(value)
      @value = value
    end

    def compare(value)
      MrbRSpec.assert_includes(value, @value)
    end

    def compare_not(value)
      MrbRSpec.refute_includes(value, @value)
    end
  end
end
