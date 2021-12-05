def read_file
  lines = File.readlines('inputs/day5.txt')
  lines.map {|line| /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/.match(line).named_captures.to_h { |k, v| [k.to_sym, v.to_i] } }
end

def create_layout(coordinates)
  layout = Hash.new(0)

  coordinates.each do |coordinate|
    if coordinate[:x1] == coordinate[:x2]
      lower_y, higher_y = [coordinate[:y1], coordinate[:y2]].minmax
      (lower_y..higher_y).each do |y|
        key = "#{coordinate[:x1]};#{y}"
        layout[key] += 1
      end
    end

    if coordinate[:y1] == coordinate[:y2]
      lower_x, higher_x = [coordinate[:x1], coordinate[:x2]].minmax
      (lower_x..higher_x).each do |x|
        key = "#{x};#{coordinate[:y1]}"
        layout[key] += 1
      end
    end
  end

  layout
end

def part1(input)
  layout = create_layout(input)
  puts "Overlapping points: #{layout.count { |k, v| v > 1 }}"
end

def part2(input)

end

part1(read_file)
#part2(read_file)