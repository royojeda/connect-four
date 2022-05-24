class Grid
  attr_accessor :columns

  def initialize(columns: Array.new(7, Column.new))
    @columns = columns
  end

  def full?
    columns.each do |column|
      return false unless column.full?
    end
    true
  end
end
