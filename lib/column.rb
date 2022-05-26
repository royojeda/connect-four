class Column
  attr_reader :rows

  def initialize(rows: Array.new(6, ' '))
    @rows = rows
  end

  def full?
    rows.none?(' ')
  end
end
