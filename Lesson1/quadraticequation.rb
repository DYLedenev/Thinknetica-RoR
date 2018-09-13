puts 'Enter an A value:'
a = gets.chomp.to_f
puts 'Enter a B value:'
b = gets.chomp.to_f
puts 'Enter a C value:'
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d > 0
  q = Math.sqrt(d)
  х1 = (-b + q) / (2 * a)
  x2 = (-b - q) / (2 * a)
  puts "The roots are X1 = #{x1} and X2 = #{x2}"
elsif d.zero?
  x = -b / (2 * a)
  puts "The roots are X1 = X2 = #{x}"
else
  puts 'There are no roots'
end
