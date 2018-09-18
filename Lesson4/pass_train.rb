# class for passenger trains
class PassengerTrain < Train
  def type
    'passenger'
  end

  def wagon_allowed?(wagon)
    wagon.class == PassengerWagon
  end
end
