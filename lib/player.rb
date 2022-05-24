class Player
  attr_accessor :move

  def initialize(move: nil)
    @move = move
  end

  def play
    input = gets.chomp.to_i
    self.move = input if input.between?(1, 7)
  end
end
