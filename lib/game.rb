class Game
  attr_accessor :input

  def accept_input
    self.input = gets.chomp.to_i
  end
end
