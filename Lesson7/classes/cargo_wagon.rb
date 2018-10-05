# class for cargo wagons
class CargoWagon < Wagon
  def use_capacity(how_much)
    raise 'Error: not enough free capacity' if @used_capacity >= @capacity
    @used_capacity += how_much if how_much.integer?
    used_capacity
  end

  def used_capacity
    puts "Volume used: #{@used_capacity}. Free space available: #{@capacity}"
  end

  def type
    'Cargo Wagon'
  end
end
