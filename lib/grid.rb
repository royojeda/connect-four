class Grid
  attr_reader :columns

  def initialize(columns: [Column.new, Column.new, Column.new, Column.new, Column.new, Column.new, Column.new])
    @columns = columns
  end

  def full?
    columns.all?(&:full?)
  end

  def fits?(turn)
    selected_column_index = turn.move - 1
    if columns[selected_column_index].full?
      turn.error = 'That column is full. Please select another one.'
      false
    else
      true
    end
  end

  def insert(turn)
    columns[turn.move - 1].drop_in(turn.player)
  end

  def display
    grid_layout = <<~TEXT
      \u250C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u2510
      \u2502 #{columns[0].rows[5]} \u2502 #{columns[1].rows[5]} \u2502 #{columns[2].rows[5]} \u2502 #{columns[3].rows[5]} \u2502 #{columns[4].rows[5]} \u2502 #{columns[5].rows[5]} \u2502 #{columns[6].rows[5]} \u2502
      \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
      \u2502 #{columns[0].rows[4]} \u2502 #{columns[1].rows[4]} \u2502 #{columns[2].rows[4]} \u2502 #{columns[3].rows[4]} \u2502 #{columns[4].rows[4]} \u2502 #{columns[5].rows[4]} \u2502 #{columns[6].rows[4]} \u2502
      \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
      \u2502 #{columns[0].rows[3]} \u2502 #{columns[1].rows[3]} \u2502 #{columns[2].rows[3]} \u2502 #{columns[3].rows[3]} \u2502 #{columns[4].rows[3]} \u2502 #{columns[5].rows[3]} \u2502 #{columns[6].rows[3]} \u2502
      \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
      \u2502 #{columns[0].rows[2]} \u2502 #{columns[1].rows[2]} \u2502 #{columns[2].rows[2]} \u2502 #{columns[3].rows[2]} \u2502 #{columns[4].rows[2]} \u2502 #{columns[5].rows[2]} \u2502 #{columns[6].rows[2]} \u2502
      \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
      \u2502 #{columns[0].rows[1]} \u2502 #{columns[1].rows[1]} \u2502 #{columns[2].rows[1]} \u2502 #{columns[3].rows[1]} \u2502 #{columns[4].rows[1]} \u2502 #{columns[5].rows[1]} \u2502 #{columns[6].rows[1]} \u2502
      \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
      \u2502 #{columns[0].rows[0]} \u2502 #{columns[1].rows[0]} \u2502 #{columns[2].rows[0]} \u2502 #{columns[3].rows[0]} \u2502 #{columns[4].rows[0]} \u2502 #{columns[5].rows[0]} \u2502 #{columns[6].rows[0]} \u2502
      \u2514\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2518

    TEXT
    puts grid_layout
  end

  def four_horizontal?
    row = 0
    until row == 6
      leftmost = 0
      until leftmost == 4
        return true if columns[leftmost].rows[row] != '  ' &&
                       columns[leftmost + 1].rows[row] == columns[leftmost].rows[row] &&
                       columns[leftmost + 2].rows[row] == columns[leftmost].rows[row] &&
                       columns[leftmost + 3].rows[row] == columns[leftmost].rows[row]

        leftmost += 1
      end
      row += 1
    end
    false
  end

  def four_vertical?
    column = 0
    until column == 7
      lowest = 0
      until lowest == 3
        return true if columns[column].rows[lowest] != '  ' &&
                       columns[column].rows[lowest + 1] == columns[column].rows[lowest] &&
                       columns[column].rows[lowest + 2] == columns[column].rows[lowest] &&
                       columns[column].rows[lowest + 3] == columns[column].rows[lowest]

        lowest += 1
      end
      column += 1
    end
    false
  end

  def four_diagonal?
    row = 0
    until row == 6
      leftmost = 0
      until leftmost == 4
        return true if columns[leftmost].rows[row] != '  ' &&
                       ((columns[leftmost + 1].rows[row + 1] == columns[leftmost].rows[row] &&
                       columns[leftmost + 2].rows[row + 2] == columns[leftmost].rows[row] &&
                       columns[leftmost + 3].rows[row + 3] == columns[leftmost].rows[row]) ||
                       (columns[leftmost + 1].rows[row - 1] == columns[leftmost].rows[row] &&
                       columns[leftmost + 2].rows[row - 2] == columns[leftmost].rows[row] &&
                       columns[leftmost + 3].rows[row - 3] == columns[leftmost].rows[row]))

        leftmost += 1
      end
      row += 1
    end
    false
  end

  def four_connected?
    four_horizontal? || four_vertical? || four_diagonal?
  end
end
