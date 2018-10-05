# class for passenger wagons
class PassengerWagon < Wagon
  def use_seats
    raise 'Error: all seats are busy' if @used_capacity >= @capacity
    @used_capacity += 1
    used_capacity
  end

  def used_capacity
    puts "Seats used: #{@used_capacity}. Free speats left: #{@capacity}"
  end

  def type
    'Passenger Wagon'
  end
end
