class Game
  attr_accessor :input

  def initialize(input: nil)
    @input = input
  end

  def accept_input
    self.input = gets.chomp.to_i
  end

  def within_range?
    input.between?(1, 7)
  end
end
