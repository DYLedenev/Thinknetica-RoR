hash = {}
summ = 0
loop do
  puts 'Enter the purchase name'
  item = gets.chomp.to_s
  puts 'Enter the price per piece'
  price = gets.chomp.to_i
  puts 'Enter the number of pieces you bought'
  pcs = gets.chomp.to_f
  break if item == 'stop' || price == 'stop' || pcs == 'stop'
  hash[item] = { price => pcs }
end

hash.each { |_key, value| value.each { |subkey, subvalue| summ += subkey * subvalue } }
hash.each do |key, value|
  puts " - is a price for #{key}:#{value.each { |subkey, subvalue| puts (subkey * subvalue).to_s }} \n"
end
puts "TOTAL price is: #{summ}"
