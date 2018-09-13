alphabet = ('a'..'z').to_a
vowels = %w[a e i o u y]
hash = {}

alphabet.each_with_index { |vowel, index| hash[alphabet[index]] = index if vowels.include?(vowel) }
puts hash
