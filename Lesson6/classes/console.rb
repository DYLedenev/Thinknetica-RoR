# general user interface Class.
class Console
  include Validation
  include Questions

  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
    @wagons = {}
    show_menu
  end

  def create_station
    new_station_name = ask_station_name
    @stations[new_station_name] = Station.new(new_station_name)
    puts "LOG: Station #{new_station_name} has been created" if @stations[new_station_name]
  end

  def create_train
    new_train_type = ask_for_new_train_number
    new_train_number = ask_for_type
    # train_exist?(new_train_number)
    if new_train_type == 1
      train = CargoTrain.new(new_train_number)
    elsif new_train_type == 2
      train = PassengerTrain.new(new_train_number)
    end
    @trains[new_train_number] = train
    puts "LOG: #{train.type} train ##{train.number} has been created" if @trains[new_train_number]
  end

  def create_route
    new_route_number = ask_for_new_route_number
    stations = [ask_for_first_station, ask_for_second_station]
    raise 'ERROR: route with the same number already exists' if @routes.include?(new_route_number)
    raise "ERROR: cannot find one of the inputed stations. Existing stations: #{@stations.keys}" unless stations_exist?(stations[0], stations[1])
    @routes[new_route_number] = Route.new(@stations[stations[0]], @stations[stations[1]])
    puts "LOG: route ##{new_route_number} from #{stations[0]} to #{stations[1]} has been created"
  end

  def add_station_to_route
    ask_and_check_route
    ask_and_check_station
    include_station_to_route(station_name, route_number)
  end

  def delete_station_from_route
    ask_and_check_route
    ask_and_check_station
    raise "ERROR: there is no such station in the list: #{show_stations_in_route(route_number)}" unless route_has_station?(route_number, station_name)
    route_delete_station(route_number, station_name)
  end

  def assign_route_to_train(train_number, route_number)
    @trains[train_number].assign_route(@routes[route_number])
    puts "LOG: route #{route_number} successfully assigned to the train ##{train_number}"
  end

  def set_route_to_train
    train_number = ask_for_train
    route_number = ask_for_route
    assign_route_to_train(train_number, route_number)
  end

  def add_wagon_to_train
    ask_for_train_number
    ask_and_check_wagon_number
    if @trains[train_number].class == CargoTrain
      wagon = CargoWagon.new
    elsif @trains[train_number].class == PassengerTrain
      wagon = PassengerWagon.new
    end
    @trains[train_number].add_wagon(wagon)
    @wagons[wagon_number] = wagon
    puts "LOG: #{wagon.type} has been successfully added to the train ##{train_number}"
  end

  def remove_wagons_from_train
    ask_for_train_number
    ask_and_check_wagon_number
    @trains[train_number].delete_wagon(@wagons[wagon_number])
    puts "LOG: wagon #{wagon_number} has been seccessfully removed from train ##{train_number}"
  end

  def move_train
    ask_for_train_number
    ask_where_to_move
    move_train_forward(@trains[train_number]) if move == 1
    move_train_backward(@trains[train_number]) if move == 2
  end

  def show_stations
    @stations.keys.each { |key| puts key }
  end

  def show_trains_on_station
    ask_and_check_station
    puts "LOG: Trains on this station: #{@stations[station].trains_list}" if @stations.include?(station)
  end

  protected # console has a child class menu so I picked protected option.

  def train_exist?(new_train_number)
    raise 'ERROR: Train with this number is alrady exist' if @trains.include?(new_train_number)
    true
  end

  def stations_exist?(station1, station2)
    raise "ERROR: There is no station with name: #{station1}" unless @stations.include?(station1)
    raise "ERROR: There is no station with name: #{station2}" unless @stations.include?(station2)
    true
  end

  def ask_for_train_number
    train_number = ask_for_train
    raise "ERROR: cannot find this train number in the list:#{@trains.keys}" unless @trains.include?(train_number)
    train_number
  end

  def ask_and_check_station
    station = ask_for_station
    raise "ERROR: cannot find this station in list:#{@stations.keys}" unless @stations.include?(station)
    station
  end

  def ask_and_check_wagon_number
    wagon_number = ask_for_wagon
    raise 'ERROR: there is no wagon with this number' unless @wagons.include?(wagon_number)
    wagon_number
  end

  def ask_and_check_route
    route_number = ask_for_route
    raise 'ERROR: there is no route with this number' unless @routes.include?(route_number)
    route_number
  end

  def move_train_forward(train)
    train.resite('forward')
    puts "LOG: train ##{train.number} is moved to #{train.station.name}"
  end

  def move_train_backward(train)
    train.resite('backward')
    puts "LOG: train ##{train.number} is moved to #{train.station.name}"
  end

  def route_has_station?(route_number, station_name)
    @routes[route_number].stations.include?(@stations[station_name])
  end

  def route_delete_station(route_number, station_name)
    @routes[route_number].delete(@stations[station_name])
    puts "LOG: station #{station_name} has been removed from the route ##{route_number}"
  end

  def show_stations_in_route(route_number)
    @routes[route_number].stations.each(&:name)
  end

  def include_station_to_route(station_name, route_number)
    raise "ERROR: cannot find station with this name. Existing stations:#{show_stations}" unless @stations.include?(station_name)
    @routes[route_number].add(@stations[station_name])
    puts "LOG: station #{station_name} successfully added to route ##{route_number}"
  end

  def show_menu
    string = { 1 => 'create station', 2 => 'create train', 3 => 'create route',
               4 => 'add station to route', 5 => 'remove station from route',
               6 => 'set route to train', 7 => 'add wagon to train', 8 => 'remove wagon from train',
               9 => 'move train forward or backward', 10 => 'show the stations list',
               11 => 'show trains on the station', 12 => 'EXIT' }
    loop do
      puts "\nSelect one of the following options:"
      string.each { |choice, text| puts "#{choice} - #{text}" }
      choice = gets.chomp.to_i
      raise 'select one of the available options, from 0 to 12' unless (0..12).cover?(choice)
      create_station if choice == 1
      create_train if choice == 2
      create_route if choice == 3
      add_station_to_route if choice == 4
      delete_station_from_route if choice == 5
      set_route_to_train if choice == 6
      add_wagon_to_train if choice == 7
      remove_wagons_from_train if choice == 8
      move_train if choice == 9
      show_stations if choice == 10
      show_trains_on_station if choice == 11
      break if choice == 12
    end
  end
end
