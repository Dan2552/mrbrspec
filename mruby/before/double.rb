module MrbRSpec
  class Double
    def initialize(name = "", args = {})
      @args = args.to_h
    end

    def method_missing(meth, *args, &blk)
      args[meth]
      super
    end
  end
end

def double(name = "", args = {})
  MrbRSpec::Double.new(name, args)
end
