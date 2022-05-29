class Turn
  attr_accessor :move, :player, :error

  def initialize(player: nil, move: nil, error: nil)
    @player = player
    @move = move
    @error = error
  end

  def prompt_input
    self.move = gets.to_i
  end

  def within_range?
    if move.between?(1, 7)
      true
    else
      self.error = 'Invalid input.'
      false
    end
  end
end
