module MrbRSpec
  class BeMatcher
    def compare(value)
      MrbRSpec.assert_less_than(value, @less_than) if @less_than
      MrbRSpec.assert_more_than(value, @more_than) if @more_than
    end

    def <(rhs)
      @less_than = rhs
      self
    end

    def >(rhs)
      @more_than = rhs
      self
    end
  end
end
