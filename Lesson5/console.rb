# A class which can: 1. create stations, 2. create trains, 3. create routes,
# 4. remove station from route, 5. add station to route, 6. assign route to trains
# 7. add wagon to train. 8. remove wagon from train, 9. move train forward or backward
# 10. show stations list, 11. show trains list per station
class Console
  include Questions

  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
    @wagons = {}
  end

  def create_station
    name = ask_station_name
    puts 'The name cannot be empty' if name.blank?
    @stations[name] = Station.new(name)
    puts "Station #{name} has been created"
  end

  def create_train
    new_train_type = create_new_train_questions[0]
    new_train_number = create_new_train_questions[1]
    if new_train_type == 1
      train = CargoTrain.new(new_train_number) unless @trains.include?(new_train_number)
    elsif new_train_type == 2
      train = PassengerTrain.new(new_train_number) unless @trains.include?(new_train_number)
    else
      puts 'Select between 1 or 2'
    end
    @trains[new_train_number] = train
    puts "#{train.type} train ##{train.number} has been created"
  end

  def create_route
    new_route_stations = create_new_route_questions[0..1]
    new_route_number = create_new_route_questions[2]
    puts 'route with the same number already exists' if @routes.include?(new_route_number)
    if @stations.include?(new_route_stations[0]) && @stations.include?(new_route_stations[1])
      @routes[new_route_number] = Route.new(@stations[new_route_stations[0]], @stations[new_route_stations[1]])
      puts "route ##{new_route_number} from #{new_route_stations[0]} to #{new_route_stations[1]} has been created"
    else
      puts "cannot find one of the inputed stations. Existing stations: #{@stations.keys}"
    end
  end

  def add_station_to_route
    route_number = ask_for_route
    puts 'the route with this number doesn\'t exist' unless @routes.include?(route_number)
    station_name = ask_for_station
    puts "the station with this name doesn't exist. Existing stations: #{@stations.keys}" unless @stations.include?(station_name)
    include_station_to_route(station_name, route_number)
  end

  def delete_station_from_route
    route_number = ask_for_route
    puts 'there is no route with this number' unless @routes.include?(route_number)
    station_name = ask_for_station_in_route
    if route_has_station?(route_number, station_name)
      route_delete_station(route_number, station_name)
    else
      puts "there is no such station in the list: #{show_stations_in_route(route_number)}"
    end
  end

  def assign_route_to_train(train_number, route_number)
    @trains[train_number].assign_route(@routes[route_number])
    puts "route #{route_number} successfully assigned to the train ##{train_number}"
  end

  def set_route_to_train
    train_number = ask_for_train
    route_number = ask_for_route
    if @trains.include?(train_number) && @routes.include?(route_number)
      assign_route_to_train(train_number, route_number)
    else
      puts 'cannot find this route or train number'
    end
  end

  def add_wagon_to_train
    train_number = ask_for_train
    wagon_number = ask_for_wagon
    if @trains[train_number].class == CargoTrain
      wagon = CargoWagon.new
    elsif @trains[train_number].class == PassengerTrain
      wagon = PassengerWagon.new
    else
      puts 'cannot find this train number'
    end
    @trains[train_number].add_wagon(wagon)
    @wagons[wagon_number] = wagon
    puts "#{wagon.type} has been successfully added to the train ##{train_number}"
  end

  def remove_wagons_from_train
    train_number = ask_for_train
    wagon_number = ask_for_wagon
    @trains[train_number].delete_wagon(@wagons[wagon_number])
    puts "cannot find this train number in the list:#{@trains.keys}" unless @trains.include?(train_number)
    puts "wagon #{wagon_number} has been seccessfully removed from train ##{train_number}"
  end

  def move_train
    train_number = ask_for_train
    move = ask_where_to_move
    move_train_forward(@trains[train_number]) if move == 1
    move_train_backward(@trains[train_number]) if move == 2
    puts 'select option 1 or 2' unless move.between?(1, 2)
  end

  def show_stations
    @stations.keys.each { |key| puts key }
  end

  def show_trains_on_station
    station = ask_for_station
    @stations[station].trains if @stations.include?(station)
    puts "cannot find this station in the list:#{@stations.keys}" unless @stations.include?(station)
  end

  protected # console has a child class menu so I picked protected option.

  def move_train_forward(train)
    train.resite('forward')
    puts "train ##{train.number} is moved to #{train.station.name}"
  end

  def move_train_backward(train)
    train.resite('backward')
    puts "train ##{train.number} is moved to #{train.station.name}"
  end

  def route_has_station?(route_number, station_name)
    @routes[route_number].stations.include?(@stations[station_name])
  end

  def route_delete_station(route_number, station_name)
    @routes[route_number].delete(@stations[station_name])
    puts "station #{station_name} has been removed from the route ##{route_number}"
  end

  def show_stations_in_route(route_number)
    @routes[route_number].stations.each(&:name)
  end

  def include_station_to_route(station_name, route_number)
    if @stations.include?(station_name)
      @routes[route_number].add(@stations[station_name])
      puts "station #{station_name} successfully added to route ##{route_number}"
    else
      puts 'cannot find station with this name. Existing stations:'
      show_stations
    end
  end
end
