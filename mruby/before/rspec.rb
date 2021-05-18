module MrbRSpec
  class Summary
    def self.instance
      @instance ||= new
    end

    def initialize
      @examples = 0
    end

    attr_accessor :examples
  end
end

module MrbRSpec
  class Describe
    def initialize(name, parent)
      @name = name
      @parent = parent
      @description = "#{indentation}describe \"#{name}\""
    end

    attr_reader :parent

    def indentation
      return "" unless parent
      parent.indentation + "  "
    end

    def children
      @children ||= []
    end

    def examples
      @examples ||= []
    end

    def lets
      @lets ||= {}
    end

    def all_lets
      return {} unless parent
      parent.all_lets.merge(lets)
    end

    def start
      examples.each do |example|
        Summary.instance.examples += 1
        # puts "#{indentation}  it \"...\""
        @current_example = example
        @let_values = {}
        self.instance_eval(&example)
      end

      children.each { |c| c.start }
    end

    def let_values
      @let_values ||= {}
    end

    def let_value(name)
      let_values[name] ||= all_lets[name]
    end

    def inspect
      "#{@description}"
    end

    def method_missing(meth, *args, &blk)
      let = let_value(meth)

      if let
        let.call(*args)
      else
        super
      end
    end
  end

  def self.configure(*args, &blk)
  end
end

RSpec = MrbRSpec

module MrbRSpec
  class Expect
    def initialize(value)
      @value = value
    end

    def to(matcher)
      if matcher.compare(@value)
        print "\e[32m.\e[0m"
      else
        print "\e[31mF\e[0m"
        puts ""
        puts matcher.why_failure(@value)
        exit 1
      end
    end
  end

  class Equal
    def initialize(value)
      @value = value
    end

    def compare(value)
      @value == value
    end

    def why_failure(value)
      puts "Comparison #{@value} == #{value} failed"
    end
  end
end

def eq(x)
  MrbRSpec::Equal.new(x)
end

def expect(x)
  MrbRSpec::Expect.new(x)
end

def _root
  @root ||= MrbRSpec::Describe.new("", nil)
end

def _current_scope
  @_current_scope ||= _root
end

def let(x, &blk)
  _current_scope.lets[x] = blk
end

def describe(x, &blk)
  new_scope = MrbRSpec::Describe.new(x, _current_scope)
  _current_scope.children << new_scope
  @_current_scope = new_scope

  unless x.is_a?(String)
    let(:described_class) { x }
  end

  blk.call
end

def context(*args, &blk)
  describe(*args, &blk)
end

def it(x, &blk)
  _current_scope.examples << blk
end

def require(*args)

end

