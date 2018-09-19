# class for passenger trains
class PassengerTrain < Train
  def wagon_allowed?(wagon)
    wagon.class == PassengerWagon
  end
end
