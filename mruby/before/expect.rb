module MrbRSpec
  class Expect
    def initialize(value)
      @value = value
    end

    def to(matcher)
      matcher.compare(@value)
    end

    def to_not(matcher)
      matcher.compare_not(@value)
    end
  end
end
