# class Train
class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :wagons, :type, :station, :speed, :route

  @@train_objects = {}

  def self.find(number)
    @@train_objects[number]
  end

  def initialize(number)
    @number = number
    @type = type
    @wagons = []
    @route = []
    @speed = 0
    @@train_objects[number] = self
    register_instance
  end

  def speed_add(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
    puts "Current speed - #{@speed}. Should be zero (0). Stop the train first." unless @speed.zero?
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
    puts "Current speed - #{@speed}. Should be zero (0). Stop the train first." unless @speed.zero?
  end

  def assign_route(route)
    route.stations.each { |station| @route << station }
    @station = route[0]
  end

  def station_position
    @route.index(@station)
  end

  def last_station?
    station_position + 1 == @route.length
  end

  def first_station?
    station_position.zero?
  end

  def next_station
    @route[station_position + 1]
  end

  def previous_station
    @route[station_position - 1]
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
    if last_station?
      puts "Current station: #{@station}, \n Previous station: #{previous_station}."
    elsif station_position.zero?
      puts "Current station: #{@station}, \n Next station: #{next_station}."
    else
      puts "Current station: #{@station},
            \nPrevious station: #{previous_station},
            \nNext station: #{next_station}.}"
    end
  end

  protected

  attr_writer :speed, :route
end
