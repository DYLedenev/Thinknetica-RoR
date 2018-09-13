puts 'Enter the triangle\'s side A value:'
a = gets.chomp.to_f
puts 'Enter the triangle\'s side B value:'
b = gets.chomp.to_f
puts 'Enter the triangle\'s side C value:'
c = gets.chomp.to_f

issqrt = a**2 == b**2 + c**2 || b**2 == a**2 + c**2 || c**2 == a**2 + b**2
isisocs = a == b || b == c || a == c

if a == b == c
  puts 'The triangle is equilateral'
elsif isisocs
  puts 'The triangle is isosceles'
elsif isqrt
  puts 'The triangle is right'
else
  puts 'The triangle is scalene'
end
