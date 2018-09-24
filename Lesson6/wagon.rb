# general class for wagons
class Wagon
  include Manufacturer
  include Validation
  attr_reader :speed, :type

  private

  attr_writer :speed, :type
end
