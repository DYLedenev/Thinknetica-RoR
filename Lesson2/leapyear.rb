months = [31, 28, 31, 30, 31, 30, 31, 30, 31, 31, 30, 31]
sum = 0

puts 'Введите день'
day = gets.chomp.to_i
puts 'Введите месяц'
month = gets.chomp.to_i
puts 'Введите год'
year = gets.chomp.to_f

i = 0
while i < month
  sum += months[i] # calculating the sum of the days in each months altogether with the entered one
  i += 1
end

if ((year % 4).zero? || !(year % 100).zero?) && (year % 400).zero?
  sum = sum - months[month] + day
else
  sum = sum - months[month] + day - 1
end

puts "#{day}-#{month}-#{year.to_i} - это #{sum}й день в году"
