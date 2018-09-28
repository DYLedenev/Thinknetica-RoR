# class Station
class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains
  @@class_exemplars = []

  validate :name, :presence
  validate :train, :presence
  # validate :train, :between_many_types, CargoTrain, PassengerTrain

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
    train_types
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
