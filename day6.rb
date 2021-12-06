def read_file
  File.read('inputs/day6.txt').split(',').map(&:to_i)
end

def simulate_day!(fish_timers)
  new_fishes = 0
  fish_timers.map! do |fish_timer|
    if fish_timer.zero?
      new_fishes += 1
      6
    else
      fish_timer - 1
    end
  end

  new_fishes.times { fish_timers << 8 }

  fish_timers
end

def part1(input)
  80.times { simulate_day!(input) }
  puts "There are #{input.length} fishes after 80 days"
end

def simulate_day_better(timer_frequencies)
  result = Hash.new(0)

  timer_frequencies.each do |timer, freq|
    if timer > 0
      result[timer - 1] += freq
    else
      result[6] += freq
      result[8] += freq
    end
  end

  result
end

def part2(input)
  timer_frequencies = input.tally
  256.times { timer_frequencies = simulate_day_better(timer_frequencies) }
  puts "There are #{timer_frequencies.values.sum} fishes after 256 days"
end

part1(read_file)
part2(read_file)
