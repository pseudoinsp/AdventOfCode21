def read_file
  lines = File.readlines('inputs/day4.txt')
  
  drawn = lines.first.split(',').map(&:to_i)

  tables_data = lines[2..-1].reject{ |line| line.strip.empty? }
  tables = tables_data.each_slice(5).to_a.map.with_index{|data, i| BingoTable.new(i + 1, data) }
  puts tables.first.columns
  return drawn, tables
end

class BingoTable

  attr_accessor :rows, :columns, :board_number

  def initialize(board_number, input)
    @board_number = board_number
    row_i = input.map{|row_input| row_input.split.map(&:to_i) }
    @rows = row_i.map do |row|
      h = Hash.new { |h, k| h[k] = false }
      row.each { |num| h[num] }
      h
    end
    
    col_i = row_i.transpose
    @columns = col_i.map do |row|
      h = Hash.new { |h, k| h[k] = false }
      row.each { |num| h[num] }
      h
    end
  end

  def has_bingo_with_number?(number)
    row_hit = rows.find{ |row| row.has_key? number }
    return false if row_hit.nil?

    col_hit = columns.find{ |col| col.has_key? number }
    
    row_hit[number] = true
    col_hit[number] = true

    row_hit.all? { |k, v| v == true } || col_hit.all? { |k, v| v == true } 
  end

  def unmarked_numbers_sum
    rows.map { |row| row.filter { |k, v| v == false }.keys }.flatten.sum
  end
end

def part1(input)
  drawn, tables = input

  catch :lolreally do
    while true
      drawn.each do |drawn_number|
        tables.each do |table|
          if table.has_bingo_with_number?(drawn_number)
            puts "Final score: #{drawn_number * table.unmarked_numbers_sum}"
            throw :lolreally
          end
        end
      end
    end
  end
end

def part2(input)
 
end

part1(read_file)
# part2(read_file)