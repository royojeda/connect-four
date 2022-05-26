# connect-four

Game
 - #play
 - #over?
 - #switch_player
 - #show_result
 - @players: ["\u26AA", "\u26AB"]
 - @current_player: players[0]
 - @turn: nil
 - @grid: Grid.new

Turn
 - #initialize
 - #prompt_input
 - #within_range?
 - #show_out_of_range_error
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
 - #overflow?
 - @columns: Array(7, Column)

Column
 - @rows: Array(6, ' ')
 - #lowest_available
 - #full?
 - #drop_in
