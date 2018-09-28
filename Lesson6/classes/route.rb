# class Route
class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  validate :stations, :presence

  def initialize(station1, station2)
    @stations = [station1, station2]
    register_instance
    valid?
    puts "LOG: route from #{station1.name} to #{station2.name} has been created"
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station)
  end

  def list
    @stations
  end
end
