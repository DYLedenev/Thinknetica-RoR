# class Route
class Route
  include InstanceCounter
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
