module MrbRSpec
  class Stubbing
    def self.stub(object, method, &blk)
      meta = class << object; self; end
      meta.send(:define_method, method, blk)
    end
  end
end
