module MrbRSpec
  class AllMatcher
    def initialize(value)
      @value = value
    end

    def compare(values)
      values.each do |value|
        @value.compare(value)
      end
    end
  end
end
