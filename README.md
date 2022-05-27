# connect-four

Game
 - #play
 - #over?
 - #switch_player
 - #show_result
 - #ensure_valid_turn
 - @players: ["\u26AA", "\u26AB"]
 - @turn: Turn.new(player: players[0])
 - @grid: Grid.new

Turn
 - #initialize
 - #prompt_input
 - #within_range?
 - @player
 - @move: nil
 - @error: nil

Grid
 - #full?
 - #four_connected?
 - #four_vertical?
 - #four_horizontal?
 - #four_diagonal?
 - #insert
 - #display
 - #fits?
 - @columns: Array(7, Column)

Column
 - @rows: Array(6, ' ')
 - #lowest_available
 - #full?
 - #drop_in
