class Game
  attr_reader :grid
  attr_accessor :players, :turn

  def initialize(grid: Grid.new,
                 players: ["\u26AA", "\u26AB"],
                 turn: Turn.new(player: players[0]))
    @grid = grid
    @turn = turn
    @players = players
  end

  def over?
    grid.full? || grid.four_connected?
  end

  def switch_player
    players.rotate!
    turn.player = players[0]
  end

  def show_result
    if grid.four_connected?
      winning_player = turn.player == "\u26AA" ? 'one' : 'two'
      puts "CONGRATULATIONS, player #{winning_player}! You've won the game"
    else
      puts 'GAME OVER! The game ends in a draw.'
    end
  end

  def ensure_valid_turn
    loop do
      turn.prompt_input
      break if turn.within_range? && grid.fits?(turn)
    end
  end

  def play
    loop do
      ensure_valid_turn
      grid.insert(turn)
      break if over?

      switch_player
    end
    show_result
  end
end
