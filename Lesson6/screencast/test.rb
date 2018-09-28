=begin
require_relative 'myerror'

# auto-embedded module for validation classes and its instances
module Validate
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  # Methods for classes (extend)
  module ClassMethods
    attr_reader :validation_base

    protected
    #method validate with parameters: name of attribute, its type, some parameters...
    def validate(attr_name, type, param = nil)
      @validation_base ||= {} # creates hash
      @validation_base[attr_name] ||= []
      @validation_base[attr_name] << { type: type, param: param }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def validate!
      # validation_base  {:name=>[{:type=>:presence, :param=>nil}, {:type=>:type, :param=>String}]}
      self.class.validation_base.each do |attr_name, params|
        instance_val = instance_variable_get("@#{attr_name}")
        params.each do |hash|
          send(hash[:type], value: instance_val, param: hash[:param], attr: attr_name)
        end
      end
    end

    def presence(options)
      attr_name, value = extract_options(options, :attr, :value)

      raise MyError, "Параметр #{attr_name} не может быть nil" if value.nil?
      raise MyError, "Параметр #{attr_name} не может быть пустым" if value == ''
    end

    def type(options)
      attr_name, value, param = extract_options(options, :attr, :value, :param)
      message_error = "Параметр #{attr_name} должен быть типа #{param}"

      raise MyError, message_error unless value.instance_of? param
    end

    def format(options)
      attr_name, value, param = extract_options(options, :attr, :value, :param)
      message_error = "Параметр #{attr_name} не соответствует рег. выражению #{param}"

      raise MyError, message_error unless value =~ param
    end

    def custom(options)
      options[:param].call(options[:value])
    end

    def extract_options(options, *keys)
      keys.map { |key| options[key] }
    end
  end
=end

# валидация
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation_choice

    def validate(name, validation_type, param = nil)
      # параметры валидации заносятся в хэш
      @validation_choice ||= []
      @validation_choice << { attr: name, type: validation_type, param: param }
    end
  end

  module InstanceMethods
    #  Запускает все проверки, указанные в классе ч/з метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том,
    # какая именно валидация не прошла
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
      puts "Что-то пошло не так. Ошибка: #{e.inspect}"
      false
    end

    private

    # - требует, чтобы значение атрибута было не nil и не пустой строкой.
    def validate_presence(name, _params)
      value = instance_variable_get("@#{name}")
      raise "#{name} не может быть пустым" if value.nil? || value.to_s.empty?
    end

    #  Треубет соответствия значения атрибута заданному регулярному выражению.
    # (отдельным параметром задается регулярное выражение для формата).
    def validate_format(name, format_value)
      value = instance_variable_get("@#{name}")
      raise "Формат #{name} задан неверно" unless value =~ format_value
    end

    # Требует соответствия значения атрибута заданному классу.
    #  отдельный параметр - класс атрибута).
    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      raise "Неверный тип #{name}. Должно быть #{type}" unless value.is_a? type
    end

    def validate_between_many_types(name, types)
      value = instance_variable_get("@#{name}")
      types = types.split(' || ')
      types.each { |type| return true if value.is_a? Object.const_get(type) }
      raise "Неверный тип #{name}. Должен быть один из: #{types}"
    end

    def validate_each_type(name, type)
      value = instance_variable_get("@#{name}")
      unless value.all? { |element| element.is_a? type }
        raise "Неверный тип. Все #{name} должны быть типа #{type}"
      end
    end

    def validate_selection(name, _params)
      value = instance_variable_get("@#{name}")
      raise "#{value} is incorrect. You should select between 1 or 2." unless value.between?(1, 2)
    end
  end
end
