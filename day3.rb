def read_file
  lines = File.readlines('inputs/day3.txt')
  lines.map { |str| str.strip.split('') }
end

def part1(input)
  gamma = input.transpose.map { |x| x.map(&:to_i).sum > input.length / 2 ? 1 : 0 }
  epsilon = gamma.map { |x| x == 1 ? 0 : 1 }
  puts "Power consumption: #{gamma.join.to_i(2) * epsilon.join.to_i(2)}"
end

def part2(input)
  oxygen_generator_rating = filter_numbers(input, method(:oxygen_generator_criteria)).join.to_i(2)
  co2_scrupper_rating = filter_numbers(input, method(:co2_scrupper_criteria)).join.to_i(2)
  puts "Life support rating: #{oxygen_generator_rating * co2_scrupper_rating}"
end

def filter_numbers(numbers, filter_criteria)
  numbers_copy = numbers.clone

  digit = 0
  while numbers_copy.length != 1
    numbers_copy = filter_numbers_by_digit(numbers_copy, digit, filter_criteria)
    digit += 1
  end

  numbers_copy[0]
end

def filter_numbers_by_digit(numbers, digit, filter_criteria)
  numbers_with_1, numbers_with_0 = numbers.partition {|num| num[digit].to_i == 1 }
  filter_criteria.call(numbers_with_1, numbers_with_0)
end

def oxygen_generator_criteria(numbers_with_1, numbers_with_0)
  numbers_with_1.length >= numbers_with_0.length ? numbers_with_1 : numbers_with_0
end

def co2_scrupper_criteria(numbers_with_1, numbers_with_0)
  numbers_with_1.length >= numbers_with_0.length ? numbers_with_0 : numbers_with_1
end

part1(read_file)
part2(read_file)