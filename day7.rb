def read_file
  File.read('inputs/day7.txt').split(',').map(&:to_i)
end

def get_optimal_position(positions, &fuel_cost_calc)
  min, max = positions.minmax

  opt_cost = 1 << 64

  (min..max).each do |poss_pos|
    cost = positions.map { |pos| fuel_cost_calc.call(poss_pos, pos) }.sum
    opt_cost = cost if cost < opt_cost
  end

  opt_cost
end

def part1(input)
  opt = get_optimal_position(input) { |possible_position, position| (possible_position - position).abs } 
  p opt
end
  
def part2(input)
  opt = get_optimal_position(input) do |possible_position, position| 
    difference = (possible_position - position).abs 
    (1..difference).sum
  end
  p opt
end
  
part1(read_file)
part2(read_file)
