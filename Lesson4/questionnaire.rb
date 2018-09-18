# methods with questions we are using for the console
# A class which can: 1. create stations, 2. create trains, 3. create routes,
# 4. remove station from route, 5. add station to route, 6. assign route to trains
# 7. add wagon to train. 8. remove wagon from train, 9. move train forward or backward
# 10. show stations list, 11. show trains list per station
class Question
  protected # all these methods are helping console to get the data from user.

  def ask_station_name
    puts 'Enter the new station\'s name:'
    gets.chomp
  end

  def create_new_train_questions
    puts "Select new train\'s type? \n1 - Cargo \n2 - Passenger:"
    selection = gets.chomp.to_i
    puts 'Enter the new train\'s number:'
    train_number = gets.chomp

    [selection, train_number]
  end

  def create_new_route_questions
    puts "Enter the name of the first station. Existing stations: #{@stations.keys}}"
    station1 = gets.chomp
    puts "Enter the name of the last station. Existing stations: #{@stations.keys}"
    station2 = gets.chomp
    puts 'Enter the new route\' number'
    route_number = gets.chomp

    [station1, station2, route_number]
  end

  def ask_for_route
    puts "Enter the route number. Existing routes: #{@routes.keys}"
    gets.chomp
  end

  def ask_for_station
    puts 'Enter the station\'s name you would like to use?'
    gets.chomp
  end

  def ask_for_station_in_route
    puts 'Which station of this route do you want to remove?'
    gets.chomp
  end

  def ask_for_train
    puts "Enter the train's number. Existing trains: #{@trains.keys}"
    gets.chomp
  end

  def ask_for_wagon
    puts "Enter the wagon's number:"
    gets.chomp
  end

  def ask_where_to_move
    puts "Where do you want to move the train? \n1 - forward \n2 - backward"
    gets.chomp.to_i
  end
end
