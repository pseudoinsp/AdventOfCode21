measurements = []
File.foreach("#{__dir__}/input.txt") { |line| measurements << line.to_i }

increases = measurements.select.with_index { |x, i| i > 0 && measurements[i] > measurements[i-1]}.count
puts "Increase in depth levels: #{increases}"