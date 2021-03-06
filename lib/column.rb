class Column
  attr_reader :rows

  def initialize(rows: ['  ', '  ', '  ', '  ', '  ', '  '])
    @rows = rows
  end

  def full?
    rows.none?('  ')
  end

  def lowest_available
    rows.index('  ')
  end

  def drop_in(token)
    rows[lowest_available] = token unless full?
  end
end
