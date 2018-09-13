puts 'What is your name?'
name = gets.chomp
puts 'Please enter your height:'
height = gets.chomp.to_i

ideal_weight = height - 110
if ideal_weight > 0
  puts "#{name}, your perfect weight is #{ideal_weight} kg"
else
  puts "#{name}, your weight is already ideal"
end
