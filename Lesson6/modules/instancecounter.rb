# contains class and variable methods for trains, stations and routes providing the number of insts.
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  # class methods mixin
  module ClassMethods
    attr_reader :instances

    def raise_instance
      @instances ||= 0
      @instances += 1
    end
  end
  # instance methods mixin
  module InstanceMethods
    def register_instance
      self.class.raise_instance
    end
  end
end
