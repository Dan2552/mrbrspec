module MrbRSpec
  def self.top_level_describes
    @top_level_describes ||= []
  end
end

def describe(x, &blk)
  new_scope = MrbRSpec::Describe.new(x, nil)

  unless x.is_a?(String)
    new_scope.let(:described_class) { x }
  end

  new_scope.instance_eval(&blk)

  MrbRSpec.top_level_describes << new_scope
end

def context(*args, &blk)
  describe(*args, &blk)
end
