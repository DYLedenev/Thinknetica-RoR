# Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли
# треугольник прямоугольным, используя теорему Пифагора (www-formula.ru) и выводит результат на экран. Также, если
# треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны), то дополнительно выводится
# информация о том, что треугольник еще и равнобедренный. Подсказка: чтобы воспользоваться теоремой Пифагора, нужно
# сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате с суммой квадратов двух остальных
# сторон. Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

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
