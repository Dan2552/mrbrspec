module MrbRSpec
  def self.active_stubs_originals
    @active_stubs_originals ||= {}
  end

  class Stubbing
    class << self
      def reset
        active_stubs = MrbRSpec.active_stubs_originals

        active_stubs.each do |object, methods|
          methods.each do |method, original_proc|
            meta = class << object; self; end
            meta.send(:define_method, method, original_proc)
          end
        end

        MrbRSpec.active_stubs_originals.clear
      end

      def stub(object, method, &blk)
        store_original(object, method)

        meta = class << object; self; end
        meta.send(:define_method, method, blk)
      end

      private

      def store_original(object, method)
        original = object.method(method).to_proc
        MrbRSpec.active_stubs_originals ||= {}
        MrbRSpec.active_stubs_originals[object] ||= {}
        MrbRSpec.active_stubs_originals[object][method] ||= original
      rescue NameError
        # In this case, there is no original method to store
      end
    end
  end
end
