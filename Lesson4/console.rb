# A class which can: 1. create stations, 2. create trains, 3. create routes,
# 4. remove station from route, 5. add station to route, 6. assign route to trains
# 7. add wagon to train. 8. remove wagon from train, 9. move train forward or backward
# 10. show stations list, 11. show trains list per station
class Console < Question
  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
    @wagons = {}
  end

  def create_station
    name = ask_station_name
    puts 'The name cannot be empty' if name == ''
    @stations[name] = Station.new(name)
    puts "Station #{name} has been created"
  end

  def create_train
    new_train = create_new_train_questions
    if new_train[0] == 1
      train = CargoTrain.new(new_train[1]) unless @trains.include?(new_train[1])
    elsif new_train[0] == 2
      train = PassengerTrain.new(new_train[1]) unless @trains.include?(new_train[1])
    else
      puts 'Select between 1 or 2'
    end
    @trains[new_train[1]] = train
    puts "#{train.type} train ##{train.number} has been created"
  end

  def create_route
    new_route = create_new_route_questions
    puts 'route with the same number already exists' if @routes.include?(new_route[2])
    if @stations.include?(new_route[0]) && @stations.include?(new_route[1])
      @routes[new_route[2]] = Route.new(@stations[new_route[0]], @stations[new_route[1]])
      puts "route ##{new_route[2]} from #{new_route[0]} to #{new_route[1]} has been created"
    else
      puts "cannot find one of the inputed stations. Existing stations: #{@stations.keys}"
    end
  end

  def add_station_to_route
    route_number = ask_for_route
    puts 'the route with this number doesn\'t exist' unless @routes.include?(route_number)
    station_name = ask_for_station
    puts "the station with this name doesn't exist. Existing stations: #{@stations.keys}" unless @stations.include?(station_name)
    @routes[route_number].add(@stations[station_name]) if @stations.include?(station_name)
    puts "station #{station_name} successfully added to route ##{route_number}"
  end

  def delete_station_from_route
    route_number = ask_for_route
    puts 'there is no route with this number' unless @routes.include?(route_number)
    station_name = ask_for_station_in_route
    if @routes[route_number].stations.include?(@stations[station_name])
      @routes[route_number].delete(@stations[station_name])
      puts "station #{station_name} has been removed from the route ##{route_number}"
    else
      puts "there is no such station in the list: #{@routes[route_number].stations.each(&:name)}"
    end
  end

  def set_route_to_train
    train_number = ask_for_train
    route_number = ask_for_route
    if @trains.include?(train_number) && @routes.include?(route_number)
      @trains[train_number].assign_route(@routes[route_number])
      puts "route #{route_number} successfully assigned to the train ##{train_number}"
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
    if move == 1
      @trains[train_number].resite('forward') unless @trains[train_number].next_station.nil?
    elsif move == 2
      @trains[train_number].resite('backward') unless @trains[train_number].previous_station.nil?
    else
      puts 'select option 1 or 2'
    end
    puts "train ##{train_number} is moved to #{@trains[train_number].station.name}"
  end

  def show_stations
    @stations.keys.each { |key| puts key }
  end

  def show_trains_on_station
    station = ask_for_station
    @stations[station].trains if @stations.include?(station)
    puts "cannot find this station in the list:#{@stations.keys}" unless @stations.include?(station)
  end
end
