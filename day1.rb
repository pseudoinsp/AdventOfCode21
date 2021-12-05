measurements = []
File.foreach("inputs/day1.txt") { |line| measurements << line.to_i }

#part1
increases = measurements.select.with_index { |x, i| i > 0 && measurements[i] > measurements[i-1]}.count
puts "Increase in depth levels: #{increases}"

#part2
sums = measurements.map.with_index { |x, i| i >= 2 ? measurements[i-2..i].sum : 9999 }
sum_increases = sums.select.with_index { |x, i| i > 0 && sums[i] > sums[i-1]}.count
puts "Increase in depth levels of 3 depth combinations: #{sum_increases}"