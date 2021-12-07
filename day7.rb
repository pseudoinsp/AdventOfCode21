def read_file
  File.read('inputs/day7.txt').split(',').map(&:to_i)
end

def get_optimal_position(positions)
  min, max = positions.minmax

  opt = { pos: -1, cost: 1 << 64 }

  (min..max).each do |poss_pos|
    cost = positions.map {|pos| (poss_pos - pos).abs }.sum

    if cost < opt[:cost]
      opt = { pos: poss_pos, cost: cost }
    end
  end

  opt
end

def part1(input)
  opt = get_optimal_position(input)
  puts opt[:cost]
end
  
def part2(input)
end
  
part1(read_file)
part2(read_file)

  