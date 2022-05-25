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

  def wait_for_valid_input
    loop do
      accept_input
      break if within_range?
    end
  end
end
