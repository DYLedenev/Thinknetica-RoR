# menu class for console class
class Menu < Console
  def initialize
    super
    string = { 1 => 'create station', 2 => 'create train', 3 => 'create route',
               4 => 'add station to route', 5 => 'remove station from route',
               6 => 'set route to train', 7 => 'add wagon to train', 8 => 'remove wagon from train',
               9 => 'move train forward or backward', 10 => 'show the stations list',
               11 => 'show trains on the station', 12 => 'EXIT' }
    loop do
      puts "\nSelect one of the following options:"
      string.each { |choice, text| puts "#{choice} - #{text}" }
      choice = gets.chomp.to_i
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
      puts 'select one of the available options, from 0 to 12' unless (0..12).cover?choice
      # i have chosen 12 for exit instead of 0 because if  the user enters any non-numberic symbol
      # or hits enter it will be converted to 0 by to_i
      break if choice == 12
    end
  end
end
