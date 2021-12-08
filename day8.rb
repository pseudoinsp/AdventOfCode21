def read_file
  lines = File.readlines('inputs/day8.txt')
  outputs = lines.map { |line| line.split('|')[1].split }
  outputs
end

def part1(outputs)
  acceptable_segment_count = [2, 3, 4, 7]
  p outputs.sum { |output| output.count { |value| acceptable_segment_count.include?(value.length) } }  
end

def part2(input)

end

part1(read_file)
part2(read_file)
  