class CustomMatcher
  def initialize(blk, value)
    instance_exec(value, &blk)
  end

  def compare(value)
    result = @match_block.call(value)

    MrbRSpec.assert(result, @failure_message.call(value))
  end

  def match(&blk)
    @match_block = blk
  end

  def failure_message(&blk)
    @failure_message = blk
  end
end
