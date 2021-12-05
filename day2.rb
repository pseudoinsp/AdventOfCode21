instructions = []
File.foreach('inputs/day2.txt') { |line| instructions << line }

# part 1
position = { x: 0, y: 0 }
instructions.each do |instr|
 if instr =~ /up (\d)/
   position[:y] -= Regexp.last_match.to_i
 elsif instr =~ /down (\d)/
   position[:y] += Regexp.last_match.to_i
 else
   position[:x] += instr[/forward (\d)/, 1].to_i
 end
end

puts "Final position coordinates multiplied #{position[:x] * position[:y]}"

# part 2
position = { x: 0, y: 0, aim: 0 }

instructions.each do |instr|
  if instr =~ /up (\d)/
    position[:aim] -= Regexp.last_match.to_i
  elsif instr =~ /down (\d)/
    position[:aim] += Regexp.last_match.to_i
  else
    change = instr[/forward (\d)/, 1].to_i
    position[:x] += change
    position[:y] += position[:aim] * change
  end
end

puts "Final position coordinates multiplied #{position[:x] * position[:y]}"
