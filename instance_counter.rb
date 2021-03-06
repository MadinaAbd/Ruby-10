module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :counter

    def instances
      @counter
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.counter ||= 0
      self.class.counter = + 1
    end
  end
end
