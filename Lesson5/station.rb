# class Station
class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@class_exemplars = []

  def self.all
    @@class_exemplars
  end

  def initialize(name)
    @name = name
    @trains = {}
    add_exemplar
    register_instance
  end

  def receive(train)
    @trains[train.number] = train
  end

  def trains_list
    @trains.keys.each { |key| puts key }
  end

  def trains_type_amount
    train_types = @trains.group_by { |_n, type| type }
    train_types.each { |type, num| puts "#{type} trains: #{num.length}" }
  end

  def departure(train, way)
    train.resite(way)
    @trains.delete(train.number)
  end

  protected

  def add_exemplar
    @@class_exemplars << self
  end
end
