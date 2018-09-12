# Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
# Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

puts "Enter the triangle's height value:"
height = gets.chomp.to_i
puts "Enter the triangle's base value:"
base = gets.chomp.to_i

square = 0.5*base*height
puts "Triangle's square is #{square}"
