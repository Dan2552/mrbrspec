module MrbRSpec
  class Double
    def initialize(name = "", args = {})
      @args = args.to_h
    end

    attr_reader :id

    def method_missing(meth, *args, &blk)
      if @args.key?(meth)
        @args[meth]
      else
        super
      end
    end
  end
end

def double(name = "", args = {})
  MrbRSpec::Double.new(name, args)
end
