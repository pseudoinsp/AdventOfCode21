def read_file
  File.read('inputs/day7.txt').split(',').map(&:to_i)
end

def get_optimal_cost(positions, &fuel_cost_calc)
  min_pos, max_pos = positions.minmax

  opt_cost = 1 << 64

  (min_pos..max_pos).each do |poss_target_pos|
    cost = positions.map { |pos| fuel_cost_calc.call(poss_target_pos, pos) }.sum
    opt_cost = cost if cost < opt_cost
  end

  opt_cost
end

def part1(input)
  p get_optimal_cost(input) { |possible_target_position, current_position| (possible_target_position - current_position).abs }
end
  
def part2(input)
  opt = get_optimal_cost(input) do |possible_target_position, current_position| 
    difference = (possible_target_position - current_position).abs 
    (1..difference).sum
  end
  
  p opt
end
  
part1(read_file)
part2(read_file)
