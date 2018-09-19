# class Station
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = {}
  end

  def receive(train)
    @trains[train.number] = train
  end

  def trains_list
    train_numbers = @trains.keys.each { |key| puts key }
    puts "Trains on this station: #{train_numbers}"
  end

  def trains_type_amount
    train_types = @trains.group_by { |_n, type| type }
    train_types.each { |type, num| puts "#{type} trains: #{num.length}" }
  end

  def departure(train, way)
    train.resite(way)
    @trains.delete(train.number)
  end
end
