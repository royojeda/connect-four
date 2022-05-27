class Game
  attr_reader :grid
  attr_accessor :players, :current_player

  def initialize(grid: Grid.new,
                 turn: nil,
                 players: ["\u26AA", "\u26AB"])
    @grid = grid
    @turn = turn
    @players = players
    @current_player = players[0]
  end

  def over?
    grid.full? || grid.four_connected?
  end

  def switch_player
    players.rotate!
    self.current_player = players[0]
  end
end
