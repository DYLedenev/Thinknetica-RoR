# class Station
class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains
  @@class_exemplars = []

  validate :name, :presence

  def self.all
    @@class_exemplars
  end

  def initialize(name)
    @name = name
    @trains = {}
    add_exemplar
    register_instance
    valid?
    puts "LOG: Station #{name} has been created"
  end

  def receive(train)
    @trains[train.number] = train
  end

  def trains_list
    @trains.values.each { |train| return train.number }
  end

  def trains_type_amount
    train_types = @trains.group_by { |_n, type| type }
    train_types.each { |type, num| puts "#{type} trains: #{num.length}" }
    train_types
  end

  def departure(train)
    @trains.delete(train.number)
  end

  protected

  def add_exemplar
    @@class_exemplars << self
  end
end
