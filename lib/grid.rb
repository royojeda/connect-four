class Grid
  attr_reader :columns

  def initialize(columns: Array.new(7, Column.new))
    @columns = columns
  end

  def full?
    columns.all?(&:full?)
  end

  def four_connected?; end

  def fits?(turn)
    selected_column_index = turn.move - 1
    !columns[selected_column_index].full?
  end

  def insert(turn)
    columns[turn.move - 1].drop_in(turn.player)
  end

  def display
    grid_layout = <<~TEXT
      #{columns[0]} #{columns[1]} #{columns[2]} #{columns[3]} #{columns[4]} #{columns[5]} #{columns[6]}
    TEXT
    puts grid_layout
  end
end
