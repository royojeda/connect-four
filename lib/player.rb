class Player
  attr_accessor :move
  attr_reader :mark

  def initialize(mark:, move: nil)
    @move = move
    @mark = mark
  end

  def play
    input = gets.chomp.to_i
    self.move = input if input.between?(1, 7)
  end
end
