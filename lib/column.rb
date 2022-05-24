class Column
  attr_accessor :lowest_available, :rows

  def initialize(lowest_available: 0, rows: Array.new(6, ' '))
    @lowest_available = lowest_available
    @rows = rows
  end

  def full?
    rows.none?(' ')
  end

  def insert(marker)
    rows[lowest_available] = marker
    self.lowest_available += 1
  end
end
