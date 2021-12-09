def read_file
  flowmap = []
  File.foreach('inputs/day9.txt') { |line| flowmap << line.strip.split('').map(&:to_i) }
  flowmap
end

def is_low_point?(field, x, y)
  dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  curr = field[x][y]

  dirs.each do |dir|
    next unless x + dir[0] >= 0 && x + dir[0] < field.length && y + dir[1] >= 0 && y + dir[1] < field[0].length

    x1 = x + dir[0]
    y1 = y + dir[1]
    return false if field[x1][y1] <= curr

  end
  true
end

def part1(flowmap)
  risk_level = 0
  flowmap.each.with_index do |line, x|
    line.each.with_index do |point, y|
      risk_level += flowmap[x][y] + 1 if is_low_point?(flowmap, x, y)
    end
  end

  p risk_level
 
end

def part2(input)
end

part1(read_file)
part2(read_file)
