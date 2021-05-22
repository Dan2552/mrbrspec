module MrbRSpec
  class Expectation
    def initialize(name, parent, &blk)
      @_expectation_name = name
      @parent = parent
      @blk = blk
    end

    attr_reader :_expectation_name

    def instance_of(cls)
      InstanceOf.new(cls)
    end

    def yield_with_args(*args)
      MrbRSpec::YieldWithArgsMatcher.new(args).tap do |m|
        _matchers << m
      end
    end

    def be_a(x)
      MrbRSpec::BeAMatcher.new(x).tap do |m|
        _matchers << m
      end
    end

    def be_an(*args)
      be_a(*args)
    end

    def be
      MrbRSpec::BeMatcher.new.tap do |m|
        _matchers << m
      end
    end

    def be_something(meth)
      MrbRSpec::BeSomethingMatcher.new(meth).tap do |m|
        _matchers << m
      end
    end

    def eq(x)
      MrbRSpec::EqualMatcher.new(x).tap do |m|
        _matchers << m
      end
    end

    def eql(x)
      MrbRSpec::EqlMatcher.new(x).tap do |m|
        _matchers << m
      end
    end

    def include(x)
      MrbRSpec::IncludeMatcher.new(x).tap do |m|
        _matchers << m
      end
    end

    def change(&blk)
      MrbRSpec::ChangeMatcher.new(blk).tap do |m|
        _matchers << m
      end
    end

    def raise_error(x = nil)
      MrbRSpec::RaiseErrorMatcher.new(x).tap do |m|
        _matchers << m
      end
    end

    def receive(x)
      MrbRSpec::ReceiveMatcher.new(x, self).tap do |m|
        _matchers << m
      end
    end

    def all(x)
      MrbRSpec::AllMatcher.new(x).tap do |m|
        _matchers << m
      end
    end

    def source_location
      file, line = @blk.source_location
      "#{file}:#{line}"
    end

    def expect(x = nil, &blk)
      if block_given? && x
        raise "expect shouldn't have a value and a block"
      elsif block_given?
        MrbRSpec::Expect.new(blk)
      else
        MrbRSpec::Expect.new(x)
      end
    end

    def is_expected(&blk)
      expect(subject, &blk)
    end

    def _start
      instance_eval(&@blk)
    end

    def _confirm_matchers
      _matchers.each do |matcher|
        matcher.after if matcher.respond_to?(:after)
      end
    end

    def _matchers
      @_matchers ||= []
    end

    def method_missing(meth, *args, &blk)
      if @parent.has_let?(meth)
        @parent.let_value(meth)
      else
        return be_something(meth) if meth.to_s.start_with?("be_") && args.count == 0
        puts "Expectation: Couldn't find method or let: #{meth}"
        super
      end
    end
  end
end
