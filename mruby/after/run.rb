class Object
  def method_missing(meth, *args, &blk)
    puts "\e[31mUndefined method '#{meth}' for #{self.class} - #{self.inspect}\e[0m"
    if caller
      print "\e[36m"
      caller.each do |line|
        puts line
      end
      print "\e[0m"
    else
      puts "\e[36mNo backtrace\e[0m"
    end
    puts ""
    super
  end
end

begin
  start = Time.now.to_f
  _top_level_describes.each do |describe|
    describe.start
  end
  finish = Time.now.to_f

  summary = MrbRSpec::Summary.instance

  puts "\n\n"

  summary.failures.each do |failure|
    puts "#{failure}"
  end

  puts "Finished in #{finish - start} seconds"
  if summary.success?
    print "\e[32m"
  else
    print "\e[31m"
  end
  puts "#{summary.examples} examples, #{summary.failures.count} failures\e[0m"
rescue => e
  puts e.inspect
  e.backtrace.each do |line|
    puts line
  end
  puts "FAILED"
end
