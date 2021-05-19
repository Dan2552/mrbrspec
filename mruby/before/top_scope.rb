def _top_level_describes
  @@_top_level_describes ||= []
end

def describe(x, &blk)
  new_scope = MrbRSpec::Describe.new(x, nil)

  unless x.is_a?(String)
    new_scope.let(:described_class) { x }
  end

  new_scope.instance_eval(&blk)

  _top_level_describes << new_scope
end

def context(*args, &blk)
  describe(*args, &blk)
end
