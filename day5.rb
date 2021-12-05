def read_file
  lines = File.readlines('inputs/day5.txt')
  lines.map { |line| /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/.match(line).named_captures.to_h { |k, v| [k.to_sym, v.to_i] } }
end

def create_layout(coordinates, count_diagonal:)
  layout = Hash.new(0)

  coordinates.each do |coordinate|
    if coordinate[:x1] == coordinate[:x2]
      lower_y, higher_y = [coordinate[:y1], coordinate[:y2]].minmax
      (lower_y..higher_y).each do |y|
        key = "#{coordinate[:x1]};#{y}"
        layout[key] += 1
      end
    elsif coordinate[:y1] == coordinate[:y2]
      lower_x, higher_x = [coordinate[:x1], coordinate[:x2]].minmax
      (lower_x..higher_x).each do |x|
        key = "#{x};#{coordinate[:y1]}"
        layout[key] += 1
      end
    elsif count_diagonal
      lower_x, higher_x = [coordinate[:x1], coordinate[:x2]].minmax
      lower_y, higher_y = [coordinate[:y1], coordinate[:y2]].minmax
      y_for_lower_x = lower_x == coordinate[:x1] ? coordinate[:y1] : coordinate[:y2]

      (lower_x..higher_x).each_with_index do |_, i|
        y = y_for_lower_x == lower_y ? lower_y + i : higher_y - i
        key = "#{lower_x + i};#{y}"
        layout[key] += 1
      end
    end
  end

  layout
end

def part1(input)
  layout = create_layout(input, count_diagonal: false)
  puts "Overlapping points: #{layout.count { |_k, v| v > 1 }}"
end

def part2(input)
  layout = create_layout(input, count_diagonal: true)
  puts "Overlapping points with diagonal: #{layout.count { |_k, v| v > 1 }}"
end

part1(read_file)
part2(read_file)
