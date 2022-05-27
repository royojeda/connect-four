class Grid
  attr_reader :columns

  def initialize(columns: Array.new(7, Column.new))
    @columns = columns
  end

  def full?
    columns.all?(&:full?)
  end

  def four_connected?; end

  def fits?; end

  def insert(move); end
end
