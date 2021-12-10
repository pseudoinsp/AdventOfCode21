def read_file
  File.readlines('inputs/day10.txt')
end

def validate_chunk(chunk)
  parens = {
    '(' => ')',
    '{' => '}',
    '[' => ']',
    '<' => '>' }

  opening_parens = parens.keys
  closing_parens = parens.values

  stack = []

  chunk.each_char do |cha|
    
    if opening_parens.include? cha
      stack << cha
    elsif closing_parens.include? cha
      match = cha == parens[stack.last]
      return [false, cha] if !match
      stack.pop  
    end
  end

  return [true]
end

def get_score_for_illegal_char(char)
  scores = {
    ')' => 3,
    '}' => 1197,
    ']' => 57,
    '>' => 25137 }

  scores[char]
end

def part1(chunks)
  error_score = 0
  chunks.each do |chunk|
    error = validate_chunk(chunk)
    error_score += get_score_for_illegal_char(error[1]) if !error[0]
  end

  p error_score
end

def part2(input)
end

part1(read_file)
# part2(read_file)
