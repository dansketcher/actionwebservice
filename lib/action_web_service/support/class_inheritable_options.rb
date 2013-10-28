# encoding: UTF-8
require 'active_support'
class Class # :nodoc:
  def class_inheritable_option(sym, default_value=nil)
    # write_inheritable_attribute sym, default_value
    class_eval <<-EOS
      class_attribute :#{sym}_val
      self.send (sym.to_s+"_val="), default_value
      # puts '************************************************************'
      # puts "self.#{sym}_val #\{self.#{sym}_val.inspect\}"
      # puts '************************************************************'

      def self.#{sym}(value=nil)
        if !value.nil?
          self.#{sym}_val = value
        else
          self.#{sym}_val
        end
      end
      
      def self.#{sym}=(value)
        self.#{sym}_val = value
      end

      def #{sym}
        self.class.#{sym}_val
      end

      def #{sym}=(value)
        self.class.#{sym}_val = value
      end
    EOS
  end
end
