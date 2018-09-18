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
    puts "Trains on this station: #{@trains.keys.each { |key| puts key }}"
  end

  def trains_type_amount
    @trains.group_by { |_n, type| type }.each { |type, num| puts "#{type} trains: #{num.length}" }
  end

  def departure(train, way)
    train.resite(way)
    @trains.delete(train.number)
  end
end
