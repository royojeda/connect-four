class Game
  attr_reader :grid

  def initialize(grid: Grid.new,
                 turn: nil,
                 players: ["\u26AA", "\u26AB"],
                 current_player: players[0])
    @grid = grid
    @turn = turn
    @players = players
    @current_player = current_player
  end

  def over?
    grid.full? || grid.four_connected?
  end
end
