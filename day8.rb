require 'set'

def read_file
  lines = File.readlines('inputs/day8.txt')
  signals = lines.map { |line| line.split('|')[0].split }
  outputs = lines.map { |line| line.split('|')[1].split } 
  [signals, outputs]
end

def part1(data)
  _, outputs = data
  acceptable_segment_count = [2, 3, 4, 7]
  p data[1].sum { |output| output.count { |value| acceptable_segment_count.include?(value.length) } }  
end

def map_segments_to_numbers(entry)
  segment_numbers_to_letters = {} # top: 0, and top bottom left right

  # digit 0 - unique to 3length compared to 2l
  three_length_entry = entry.find {|e| e.length == 3 }.chars.to_set
  two_length_entry = entry.find {|e| e.length == 2 }.chars.to_set

  null_segment_letter = three_length_entry ^ two_length_entry
  
  segment_numbers_to_letters[0] = null_segment_letter.first

  five_length_numbers = entry.filter { |s| s.length == 5 }
  six_length_numbers = entry.filter { |s| s.length == 6 }

  two_and_five_candidates = two_length_entry

  # 5 is common in all 6 length numbers from these two candidates
  five_segment = two_and_five_candidates.find { |seg| six_length_numbers.all? { |num| num.include?(seg) } }
  segment_numbers_to_letters[5] = five_segment
  # 2 is the other
  two_segment = two_and_five_candidates.find { |seg| seg != five_segment }
  segment_numbers_to_letters[2] = two_segment

  # 1, 3
  four_length_entry = entry.find {|e| e.length == 4 }.chars.to_set
  one_and_three_candidates = four_length_entry ^ two_length_entry

  # 3 is common in all 5 length numbers from these two candidates
  three_segment = one_and_three_candidates.find { |seg| five_length_numbers.all? { |num| num.include?(seg) } }
  segment_numbers_to_letters[3] = three_segment
  # 1 is the other
  one_segment = one_and_three_candidates.find { |seg| seg != three_segment }
  segment_numbers_to_letters[1] = one_segment

  #calculate missing digits #4 and #6
  paired_letters = segment_numbers_to_letters.values

  # calculate digit #4 - from the 3 numbers with six length, only one has digit 4
  possible_letters_for_4 = six_length_numbers.map { |num| num.chars.to_set - paired_letters }
  # p possible_letters_for_4
  letter_for_6 = possible_letters_for_4.find { |letters| letters.length == 1 }.first
  segment_numbers_to_letters[6] = letter_for_6
  letter_for_4 = possible_letters_for_4.find { |letters| letters.length == 2 }.find { |digit| digit != letter_for_6 }
  segment_numbers_to_letters[4] = letter_for_4

  letters_to_numbers = {}

  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 1, 2, 4, 5, 6])] = 0
  letters_to_numbers[get_letters(segment_numbers_to_letters, [2, 5])] = 1
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 2, 3, 4, 6])] = 2
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 2, 3, 5, 6])] = 3
  letters_to_numbers[get_letters(segment_numbers_to_letters, [1, 2, 3, 5])] = 4
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 1, 3, 5, 6])] = 5
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 1, 3, 4, 5, 6])] = 6
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 2, 5])] = 7
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 1, 2, 3, 4, 5, 6])] = 8
  letters_to_numbers[get_letters(segment_numbers_to_letters, [0, 1, 2, 3, 5, 6])] = 9

  letters_to_numbers
end

def get_letters(mapping, segments)
  ret = []
  segments.each { |i| ret << mapping[i] }
  ret.to_set
end

def part2(input)
  sum = 0
  signals, outputs = input
  signals.length.times do |i|
    output_digits = []
    letters_to_numbers = map_segments_to_numbers(signals[i]) 
    outputs[i].each do |o|
      output_array = Set[*o.chars]
      output_digit = letters_to_numbers.find{|k, v| k == output_array}[1]
      output_digits << output_digit
    end

    output_number = output_digits[0]*1000 + output_digits[1] * 100 + output_digits[2] * 10 + output_digits[3]
    sum += output_number
  end

  p sum
end

part1(read_file)
part2(read_file)
