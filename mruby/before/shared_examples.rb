module SharedExamples
  def self.current_describe
    @current_describe ||= []
  end

  def self.store
    @store ||= {}
  end
end

def shared_examples_for(name, &blk)
  SharedExamples.store[name] = blk
end

def it_behaves_like(name)
  describe = SharedExamples.current_describe.last
  describe.instance_eval(&SharedExamples.store[name])
end
