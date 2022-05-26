class Turn
  attr_accessor :move

  def initialize(player: nil, move: nil, error: nil)
    @player = player
    @move = move
    @error = error
  end

  def prompt_input
    self.move = gets.to_i
  end

  def within_range?
    move.between?(1, 7)
  end
end
