module MrbRSpec
  class EqualMatcher
    def initialize(value)
      @value = value
    end

    def compare(value)
      passes = false
      ors.each do |or_matcher|
        begin
          or_matcher.compare(value)
          passes = true
          break
        rescue AssertionFailure
        end
      end

      MrbRSpec.assert_equal(@value, value) unless passes
    end

    def compare_not(value)
      passes = false
      ors.each do |or_matcher|
        begin
          or_matcher.compare_not(value)
          passes = true
          break
        rescue AssertionFailure
        end
      end

      MrbRSpec.refute_equal(@value, value)
    end

    def or(value)
      ors << value
      self
    end

    def ors
      @ors ||= []
    end
  end
end
