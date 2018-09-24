# cargo_train
class CargoTrain < Train
  def wagon_allowed?(wagon)
    wagon.class == CargoWagon
  end
end
