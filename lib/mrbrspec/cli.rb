module MrbRSpec
  module CLI
    def self.start
      runner = MrbRSpec::Runner.new
      runner.start
    end
  end
end
