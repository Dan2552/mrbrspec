module MrbRSpec
  class Describe
    def initialize(name, parent)
      @name = name
      @parent = parent
      @description = "#{indentation}describe \"#{name}\""
      @root = parent == nil
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

    def befores
      @befores ||= []
    end

    def afters
      @afters ||= []
    end

    def lets
      @lets ||= {}
    end

    def has_let?(name)
      # puts "searching #{name} in #{all_lets.keys} for #{self} (parent: #{parent})"
      !all_lets[name].nil?
    end

    def describe(name, &blk)
      # puts "#{indentation}#{name}"
      child = self.class.new(name, self)
      children << child
      child.instance_eval(&blk)
    end

    def it(name, &blk)
      # puts "#{indentation}#{name}"
      example = MrbRSpec::Expectation.new(name, self, &blk)
      examples << example
    end

    def let(x, &blk)
      # puts "registered let #{x} for #{self}"
      lets[x] = blk
    end

    def subject(&blk)
      let(:subject, &blk)
    end

    def before(&blk)
      befores << blk
    end

    def after(&blk)
      afters << blk
    end

    def all_lets
      return lets unless parent
      parent.all_lets.merge(lets)
    end

    def start
      examples.each do |example|
        Summary.instance.examples += 1

        # Clear memoised lets
        @let_values = {}

        begin
          befores.each { |blk| instance_eval(&blk) }
          example._start
          example._confirm_matchers
          afters.each { |blk| instance_eval(&blk) }
          print "\e[32m.\e[0m"
        rescue AssertionFailure => e
          print "\e[31mF\e[0m"
          Summary.instance.failures << Failure.new(example, e)
        end
      end
      children.each { |c| c.start }
    end

    def let_values
      @let_values ||= {}
    end

    def let_value(name)
      let_values[name] ||= begin
        blk = all_lets[name]
        if blk
          instance_eval(&blk)
        else
          nil
        end
      end
    end

    def inspect
      "#{@description}"
    end

    def to_s
      inspect
    end

    def method_missing(meth, *args, &blk)
      if has_let?(meth)
        let_value(meth)
      else
        puts "Describe: Couldn't find method or let: #{meth}"
        super
      end
    end
  end
end
