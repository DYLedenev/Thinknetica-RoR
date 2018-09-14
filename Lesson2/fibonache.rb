array = [0, 1]
# array.each { |_i| array << array[-2] + array[-1] if array[-1] < 100 }
while array[-1] < 100 do
  array << array[-2] + array[-1]
end
array.delete(array.last)
puts array
