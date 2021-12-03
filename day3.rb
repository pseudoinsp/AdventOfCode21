def read_file
  lines = File.readlines('inputs/day3.txt')
  lines.map { |str| str.strip.split('') }
end

def part1(input)
  gamma = input.transpose.map { |x| x.map(&:to_i).sum > input.length / 2 ? 1 : 0 }
  epsilon = gamma.map { |x| x == 1 ? 0 : 1 }
  puts "Power consumption: #{gamma.join.to_i(2) * epsilon.join.to_i(2)}"
end

part1(read_file)
