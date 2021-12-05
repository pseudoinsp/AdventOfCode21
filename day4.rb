def read_file
  lines = File.readlines('inputs/day4.txt')
  
  drawn = lines.first.split(',').map(&:to_i)

  tables_data = lines[2..-1].reject{ |line| line.strip.empty? }
  tables = tables_data.each_slice(5).to_a.map.with_index{|data, i| BingoTable.new(i + 1, data) }
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
    @columns = col_i.map do |col|
      h = Hash.new { |h, k| h[k] = false }
      col.each { |num| h[num] }
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
  drawn, tables = input

  remaining_tables = tables.to_h { |table| [table.board_number, table] }

  last_drawn_number = -1
  last_table_unmarked = -1

  while remaining_tables.length > 0
    drawn.each do |drawn_number|
      remaining_tables.each do |table_id, table|
        if table.has_bingo_with_number?(drawn_number)
          if remaining_tables.length == 1
            last_drawn_number = drawn_number
            last_table_unmarked = table.unmarked_numbers_sum
          end
          remaining_tables.delete(table_id)
        end
      end
    end
  end

  puts "Final score: #{last_table_unmarked * last_drawn_number}"

end

# part1(read_file)
part2(read_file)