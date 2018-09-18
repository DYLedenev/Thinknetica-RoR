require_relative 'main'

station_moscow = Station.new('Moscow')
station_piter = Station.new('Saints Petersburg')
station_rostov = Station.new('Rostov-on-Don')
station_sochi = Station.new('Sochi')
station_anapa = Station.new('Anapa')
train1 = PassengerTrain.new('123')
train2 = PassengerTrain.new('234')
train3 = CargoTrain.new('345')
route1 = Route.new(station_moscow, station_piter)
route2 = Route.new(station_moscow, station_sochi)
route3 = Route.new(station_anapa, station_sochi)
wagon1 = PassengerWagon.new
wagon2 = PassengerWagon.new
wagon3 = CargoWagon.new

# tests:

train1.speed_add(50)
train2.speed = 60
train3.speed
train1.stop
train2.wagons
train1.add_wagon(wagon1)
train1.add_wagon(wagon2)
train3.add_wagon(wagon1)
train3.add_wagon(wagon3)
train1.delete_wagon(wagon2)
train1.assign_route(route2)
train2.assign_route(route1)
train3.assign_route(route3)
route1.add(station_rostov)
route1.add(station_anapa)
route1.add(station_sochi)
route2.add(station_rostov)
route1.delete(station_anapa)
route1.list
route2.list
route3.list
train1.station
train2.station
train3.station
train1.resite('forward')
train1.resite('backward')
train3.resite('forward')
train3.station
station_moscow.receive(train1)
station_moscow.receive(train2)
station_moscow.receive(train3)
station_moscow.trains
station_moscow.trains_type_amount
station_moscow.departure(train3, 'forward')
