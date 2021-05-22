module MrbRSpec
  class Failure
    def initialize(expectation, error)
      @expectation = expectation
      @error = error
    end

    attr_reader :expectation
    attr_reader :error

    def inspect
      # eval(DEBUGGER)
      string = "Expection failed: #{expectation._expectation_name}\n"
      string += "Expection at \e[1m#{expectation.source_location}\e[22m failed:\n"
      string += "#{error}\n"
      backtrace = error.backtrace

      string += "\e[36m"

      # backtrace = backtrace.select { |line| !line.include?("/mrbrspec/lib/mrbrspec/") }
      backtrace.each do |line|
        if line.include?("/mrbrspec/lib/mrbrspec/")
          string += "#{line}\n"
        else
          string += "\e[1m#{line}\e[22m\n"
        end
      end

      string += "\e[0m"

      string
    end

    def to_s
      inspect
    end
  end
end
