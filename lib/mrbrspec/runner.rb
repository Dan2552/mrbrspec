module MrbRSpec
  class Runner
    def start
      this_dir = __dir__

      mrbc = "mrbc"
      mrbc = "mundle exec mrbc" if File.file?(File.join(Dir.pwd, "Mundlefile"))

      mruby = "mruby"
      mruby = "mundle exec mruby" if File.file?(File.join(Dir.pwd, "Mundlefile"))

      output = "mrbrspec"
      before_files = Dir.glob(File.join(this_dir, "..", "..", "mruby", "before", "*.rb"))
      app_spec_files = Dir.glob(File.join("spec", "*.rb"))
      after_files = Dir.glob(File.join(this_dir, "..", "..", "mruby", "after", "*.rb"))

      compile = (%W(#{mrbc} -o#{output} -g) + before_files + app_spec_files + after_files).join(" ")
      chmod = "chmod +x #{output}"
      execute = "#{mruby} #{output}"

      system(compile) || raise("Failed to compiled")
      system(chmod) || raise("Failed to chmod")
      system(execute)
    end
  end
end
