# provides possibility of validating user input
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation_choice

    def validate(name, validation_type, param = nil)
      @validation_choice ||= []
      @validation_choice << { attr: name, type: validation_type, param: param }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation_choice.each do |choice|
        validation_method = "validate_#{choice[:type]}".to_sym
        send(validation_method, choice[:attr], choice[:param])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError => e
      puts "Something went wrong. Error: #{e.inspect}"
      false
    end

    private

    def validate_presence(name, _params)
      value = instance_variable_get("@#{name}")
      raise "#{name} cannot be empty" if value.nil? || value.to_s.empty?
    end

    def validate_format(name, format_value)
      value = instance_variable_get("@#{name}")
      raise "The format of the #{name} is invalid" unless value =~ format_value
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      raise "Incorrect type of #{name}. Should be #{type}" unless value.is_a? type
    end

    def validate_between_many_types(name, types)
      value = instance_variable_get("@#{name}")
      types = types.split(' || ')
      types.each { |type| return true if value.is_a? Object.const_get(type) }
      raise "Неверный тип #{name}. Должен быть один из: #{types}"
    end

    def validate_selection(name, _params)
      value = instance_variable_get("@#{name}")
      raise "#{value} is incorrect. You should select between 1 or 2." unless value.between?(1, 2)
    end
  end
end
