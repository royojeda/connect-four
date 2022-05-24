class Player
  attr_accessor :move

  def initialize(move: nil)
    @move = move
  end

  def play
    self.move = gets.chomp.to_i
  end
end
