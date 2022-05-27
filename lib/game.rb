class Game
  attr_reader :grid, :turn
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

  def show_result
    if grid.four_connected?
      winning_player = current_player == "\u26AA" ? 'one' : 'two'
      puts "CONGRATULATIONS, player #{winning_player}! You've won the game"
    else
      puts 'GAME OVER! The game ends in a draw.'
    end
  end

  def ensure_valid_turn
    loop do
      turn.prompt_input
      break if turn.within_range? && grid.fits?
    end
  end
end
