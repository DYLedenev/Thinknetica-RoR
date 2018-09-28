# class Route
class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  validate :station1, :presence
  validate :station2, :presence
  validate :station1, :type, Station
  validate :station2, :type, Station

  def initialize(station1, station2)
    @stations = [station1, station2]
    register_instance
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
