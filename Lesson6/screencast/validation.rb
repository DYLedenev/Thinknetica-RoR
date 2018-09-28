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
end

=begin
module Validation
  def valid_station?(name)
    validate_station_name!(name)
  rescue
    false
  end

  def valid_train_number?(train_number)
    validate_train_number!(train_number)
  rescue
    false
  end

  protected

  NUMBER_FORMAT = /^\w{3}\-*\w{2}$/im

  def validate!(what)
    raise 'Value cannot be empty' if what.empty?
    true
  end

  def validate_station_name!(name)
    validate!(name)
    raise 'Name should contain at least 2 letters' if name.size < 2
    true
  end

  def validate_train_number!(train_number)
    validate!(train_number)
    raise 'Incorrect number format (try ххх-хх OR xxxxx)' unless train_number =~ NUMBER_FORMAT
    true
  end

  def validate_type!(type)
    raise 'Select between 1 or 2' unless type.between?(1, 2)
    true
  end
end
=end
