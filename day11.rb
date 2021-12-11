require 'set'

def read_file
  File.foreach('inputs/day11.txt').reduce([]) { |map, line| map << line.strip.split('').map(&:to_i) }
end

$total_flashes = 0

def do_step(field)
  to_flash = Set.new
  # 1. increase by 1, store if > 9
  field.each.with_index do |line, x|
    line.each.with_index do |point, y|
      field[x][y] += 1
      to_flash.add([x, y]) if field[x][y] > 9
    end
  end

  flashed = Set.new
  # 2. increase neighbours of flashing points by 1
  # if they are also flashing, add them to the to_flash set
  until to_flash.empty?
    curr_cord = to_flash.first
    to_flash.delete(curr_cord)
    flashed.add(curr_cord)
    $total_flashes += 1

    dirs = [[-1, 0], [-1, -1], [0, 1], [1, -1], [1, 0], [1, 1], [0, -1], [-1, 1]]
    x = curr_cord[0]
    y = curr_cord[1]

    dirs.each do |dir|
      next unless x + dir[0] >= 0 && x + dir[0] < field.length && y + dir[1] >= 0 && y + dir[1] < field[0].length

      x1 = x + dir[0]
      y1 = y + dir[1]
      field[x1][y1] += 1

      to_flash.add([x1, y1]) if field[x1][y1] > 9 && !flashed.include?([x1, y1])
    end
  end

  # 3. set every flashed point to 0
  flashed.each do |x, y|
    field[x][y] = 0
  end

  field
end

def part1(map)
  100.times { do_step(map) }
  p $total_flashes
end

def part2(map)
  step = 0

  loop do
    field = do_step(map)
    step += 1

    break if field.flatten.uniq.length == 1
  end

  p step
end

part1(read_file)
part2(read_file)
