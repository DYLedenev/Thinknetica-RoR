# class Station
class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = {}
  end

  def receive(train)
    @trains[train.number] = train
  end

  def trains_list
    puts "Train on this station: #{@trains.keys.each { |key| puts key }}"
  end

  def trains_type_amount
    @trains.group_by { |_n, type| type }.each { |type, num| puts "#{type} trains: #{num.length}" }
  end

  def departure(train, where)
    train.move(where)
    @trains.delete(train.number)
  end
end

# class Route
class Route
  attr_reader :stations

  def initialize(station1, station2)
    @stations = [station1, station2]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station)
  end

  def list
    puts @stations
  end
end

# class Train
class Train
  attr_accessor :speed, :route
  attr_reader :number, :wagons, :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @route = []
    @speed = 0
  end

  def speed_add(speed)
    @speed += speed
  end

  def speed?
    puts "train current speed is: #{@speed}"
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed.zero?
    puts "number of wagons: #{@wagons}"
  end

  def delete_wagon
    @wagons -= 1 if @speed.zero?
    puts "number of wagons: #{@wagons}"
  end

  def assign_route(route)
    route = route.stations
    route.each { |station| @route << station }
    @station = route[0]
  end

  def last_station?
    @route.index(@station) + 1 == @route.length
  end

  def first_station?
    @route.index(@station).zero?
  end

  def next_station
    @route[@route.index(@station) + 1]
  end

  def previous_station
    @route[@route.index(@station) - 1]
  end

  def resite(way)
    if way == 'forward'
      @station = next_station unless last_station?
    elsif way == 'backward'
      @station = previous_station unless first_station?
    else
      puts 'enter "forward" or "backward".'
    end
  end

  def current_station
    if @route.index(@station) + 1 <= @route.length
      puts "Current station: #{@station}, \n Previous station: #{previous_station}."
    elsif @route.index(@station).zero?
      puts "Current station: #{@station}, \n Next station: #{next_station}."
    else
      puts "Current station: #{@station}, \nPrevious station: #{previous_station}, \nNext station: #{next_station}.}"
    end
  end
end
