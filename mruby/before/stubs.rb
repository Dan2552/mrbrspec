def require(*args)
end

module MrbRSpec
  def self.configure(*args, &blk)
  end
end

RSpec = MrbRSpec

module Bundler
  class Path
    def join(*args)
      Dir.pwd + "/" + args.join("/")
    end
  end

  def self.root
    Path.new
  end
end
