module MrbRSpec
  class InstanceOf
    def initialize(value)
      @value = value
    end

    def ==(comparison)
      comparison.is_a?(@value)
    end
  end
end
