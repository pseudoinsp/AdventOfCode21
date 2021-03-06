def read_file
  File.readlines('inputs/day10.txt')
end

def validate_chunk(chunk)
  parens = {
    '(' => ')',
    '{' => '}',
    '[' => ']',
    '<' => '>'
  }

  opening_parens = parens.keys
  closing_parens = parens.values

  characters = []

  chunk.each_char do |cha|
    if opening_parens.include? cha
      characters << cha
    elsif closing_parens.include? cha
      match = cha == parens[characters.last]
      return [false, cha] unless match

      characters.pop
    end
  end

  [true]
end

def get_score_for_illegal_char(char)
  scores = {
    ')' => 3,
    '}' => 1197,
    ']' => 57,
    '>' => 25_137
  }

  scores[char]
end

def part1(chunks)
  error_score = 0
  chunks.each do |chunk|
    error = validate_chunk(chunk)
    error_score += get_score_for_illegal_char(error[1]) unless error[0]
  end

  p error_score
end

def get_missing_chars_for_chunk(chunk)
  parens = {
    ')' => '(',
    '}' => '{',
    ']' => '[',
    '>' => '<'
  }

  open_to_close = {
    '(' => ')',
    '{' => '}',
    '[' => ']',
    '<' => '>'
  }

  opening_parens = parens.values
  closing_parens = parens.keys

  opening_parens_loc = Hash.new { |hash, key| hash[key] = [] }

  chunk.each_char.with_index do |cha, i|
    if opening_parens.include? cha
      opening_parens_loc[cha] << i
    elsif closing_parens.include? cha
      paired_open = parens[cha]
      opening_parens_loc[paired_open].pop
    end
  end

  locations_and_closing_chars_ = {}
  opening_parens_loc.each { |open_char, occurances| occurances.each { |occ| locations_and_closing_chars_[occ] = open_to_close[open_char] } }
  closing_chars_sorted = locations_and_closing_chars_.sort_by { |k, _v| k }.reverse.map { |_occ, close_char| close_char }.join
  closing_chars_sorted
end

def calculate_score_from_closing_chars(characters)
  scores = {
    ')' => 1,
    '}' => 3,
    ']' => 2,
    '>' => 4
  }

  characters.chars.reduce(0) { |score, cha| score * 5 + scores[cha] }
end

def part2(chunks)
  scores = []
  incomplete_chunks = chunks.reject { |chunk| validate_chunk(chunk)[0] == false }
  incomplete_chunks.each do |chunk|
    chars = get_missing_chars_for_chunk(chunk)
    score = calculate_score_from_closing_chars(chars)
    scores << score
  end

  scores.sort!
  p scores[scores.length / 2]
end

part1(read_file)
part2(read_file)
