module MrbRSpec
  class Summary
    def self.instance
      @instance ||= new
    end

    def initialize
      @examples = 0
      @failures = []
    end

    attr_accessor :examples
    attr_reader :failures

    def success?
      failures.count == 0
    end
  end
end
