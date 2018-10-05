# general class for wagons
class Wagon
  include Manufacturer
  include Valdiation
  include InstanceCounter

  attr_reader :capacity, :used_capacity
  NUMBER = /^\d+$/m

  validate :number, :presence
  validate :capacity, :presence
  validate :capacity, :format, NUMBER

  def initialize(number, capacity)
    @number = number
    @capacity = capacity
    @used_capacity = 0
    register_instance
    valid?
  end

  protected

  attr_writer :capacity
end
