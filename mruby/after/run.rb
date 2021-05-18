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
  _root.start
  finish = Time.now.to_f

  puts "\n\nFinished in #{finish - start} seconds"
  puts "\e[32m#{MrbRSpec::Summary.instance.examples} examples, 0 failures\e[0m"
rescue => e
  puts e.inspect
  e.backtrace.each do |line|
    puts line
  end
  puts "FAILED"
end
