# cargo_train
class CargoTrain < Train
  def type
    'cargo'
  end

  def wagon_allowed?(wagon)
    wagon.class == CargoWagon
  end
end
