# class Train
class Train
  attr_accessor :speed, :route
  attr_reader :number, :wagons, :type, :station

  def initialize(number)
    @number = number
    @type = type
    @wagons = []
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

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
    puts "Current speed - #{@speed}. Should be zero (0). Stop the train first." unless @speed.zero?
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
    puts "Current speed - #{@speed}. Should be zero (0). Stop the train first." unless @speed.zero?
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
      puts "Current station: #{@station},
            \nPrevious station: #{previous_station},
            \nNext station: #{next_station}.}"
    end
  end
end
