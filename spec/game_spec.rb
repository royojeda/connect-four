require './lib/game'
require './lib/grid'
require './lib/turn'

describe Game do
  describe '#over?' do
    subject(:over_game) { described_class.new(grid: test_grid) }

    let(:test_grid) { instance_double(Grid) }

    context 'when the @grid is full' do
      before do
        allow(test_grid).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        expect(over_game.over?).to be(true)
      end
    end

    context 'when the @grid has four tokens connected' do
      before do
        allow(test_grid).to receive(:full?)
        allow(test_grid).to receive(:four_connected?).and_return(true)
      end

      it 'returns true' do
        expect(over_game.over?).to be(true)
      end
    end

    context 'when the @grid is not full and no four tokens are connected' do
      before do
        allow(test_grid).to receive(:full?).and_return(false)
        allow(test_grid).to receive(:four_connected?).and_return(false)
      end

      it 'returns false' do
        expect(over_game.over?).to be(false)
      end
    end
  end

  describe '#switch_player' do
    context 'when @current_player is player_one' do
      test_players = ["\u26AA", "\u26AB"]

      subject(:switch_game) { described_class.new(players: test_players, turn: test_turn) }

      let(:test_turn) { instance_double(Turn) }

      before do
        allow(test_turn).to receive(:player=)
        switch_game.switch_player
      end

      it 'sends Turn#player with player_two' do
        expect(test_turn).to have_received(:player=).with("\u26AB")
      end
    end

    context 'when @current_player is player_two' do
      test_players = ["\u26AB", "\u26AA"]

      subject(:switch_game) { described_class.new(players: test_players, turn: test_turn) }

      let(:test_turn) { instance_double(Turn) }

      before do
        allow(test_turn).to receive(:player=)
        switch_game.switch_player
      end

      it 'sends Turn#player with player_one' do
        expect(test_turn).to have_received(:player=).with("\u26AA")
      end
    end
  end

  describe '#show_result' do
    subject(:result_game) { described_class.new(turn: test_turn, grid: test_grid) }

    let(:test_grid) { instance_double(Grid) }
    let(:test_turn) { instance_double(Turn) }

    context 'when player_one is the winner' do
      before do
        player_one = "\u26AA"
        allow(test_turn).to receive(:player).and_return(player_one)
        allow(test_grid).to receive(:full?)
        allow(test_grid).to receive(:four_connected?).and_return(true)
        allow(result_game).to receive(:puts)
        result_game.show_result
      end

      it "prints a 'congratulations player one' message" do
        expected = "CONGRATULATIONS, player one! You've won the game"
        expect(result_game).to have_received(:puts).with(expected)
      end
    end

    context 'when player_two is the winner' do
      before do
        player_two = "\u26AB"
        allow(test_turn).to receive(:player).and_return(player_two)
        allow(test_grid).to receive(:full?)
        allow(test_grid).to receive(:four_connected?).and_return(true)
        allow(result_game).to receive(:puts)
        result_game.show_result
      end

      it "prints a 'congratulations player two' message" do
        expected = "CONGRATULATIONS, player two! You've won the game"
        expect(result_game).to have_received(:puts).with(expected)
      end
    end

    context 'when the game is tied' do
      before do
        allow(test_grid).to receive(:four_connected?).and_return(false)
        allow(result_game).to receive(:puts)
        result_game.show_result
      end

      it "prints a 'tied game' message" do
        expected = 'GAME OVER! The game ends in a draw.'
        expect(result_game).to have_received(:puts).with(expected)
      end
    end
  end

  describe '#ensure_valid_turn' do
    subject(:turn_game) { described_class.new(turn: test_turn, grid: test_grid) }

    let(:test_turn) { instance_double(Turn) }
    let(:test_grid) { instance_double(Grid) }

    context 'when Turn.move is out of range once' do
      before do
        allow(test_turn).to receive(:prompt_input)
        allow(test_turn).to receive(:within_range?).and_return(false, true)
        allow(test_grid).to receive(:fits?).and_return(true)
      end

      it 'calls Turn.prompt_input twice' do
        expect(test_turn).to receive(:prompt_input).twice
        turn_game.ensure_valid_turn
      end
    end

    context 'when Turn.move is out of range 3 times' do
      before do
        allow(test_turn).to receive(:prompt_input)
        allow(test_turn).to receive(:within_range?).and_return(false, false, false, true)
        allow(test_grid).to receive(:fits?).and_return(true)
      end

      it 'calls Turn.prompt_input 4 times' do
        expect(test_turn).to receive(:prompt_input).exactly(4).times
        turn_game.ensure_valid_turn
      end
    end

    context 'when Turn.move overflows the grid twice' do
      before do
        allow(test_turn).to receive(:prompt_input)
        allow(test_turn).to receive(:within_range?).and_return(true)
        allow(test_grid).to receive(:fits?).and_return(false, false, true)
      end

      it 'calls Turn.prompt_input 3 times' do
        expect(test_turn).to receive(:prompt_input).exactly(3).times
        turn_game.ensure_valid_turn
      end
    end

    context "when Turn.move doesn't overflow the grid" do
      before do
        allow(test_turn).to receive(:prompt_input)
        allow(test_turn).to receive(:within_range?).and_return(true)
        allow(test_grid).to receive(:fits?).and_return(true)
      end

      it 'calls Turn.prompt_input once' do
        expect(test_turn).to receive(:prompt_input).once
        turn_game.ensure_valid_turn
      end
    end
  end

  describe '#play' do
    subject(:play_game) { described_class.new(turn: test_turn, grid: test_grid) }

    let(:test_turn) { instance_double(Turn) }
    let(:test_grid) { instance_double(Grid) }

    before do
      allow(test_grid).to receive(:insert)
      allow(play_game).to receive(:ensure_valid_turn)
      allow(play_game).to receive(:show_result)
      allow(play_game).to receive(:switch_player)
    end

    context 'when Game#over? is true' do
      before do
        allow(play_game).to receive(:over?).and_return(true)
        play_game.play
      end

      it 'sends Game#ensure_valid_turn once' do
        expect(play_game).to have_received(:ensure_valid_turn).once
      end

      it 'sends Grid#insert once' do
        expect(test_grid).to have_received(:insert).with(play_game.turn).once
      end

      it "doesn't send Game#switch_player" do
        expect(play_game).not_to have_received(:switch_player)
      end

      it 'sends Game#show_result once' do
        expect(play_game).to have_received(:show_result).once
      end
    end

    context 'when Game#over? is false once' do
      before do
        allow(play_game).to receive(:over?).and_return(false, true)
        play_game.play
      end

      it 'sends Game#ensure_valid_turn twice' do
        expect(play_game).to have_received(:ensure_valid_turn).twice
      end

      it 'sends Grid#insert twice' do
        expect(test_grid).to have_received(:insert).with(play_game.turn).twice
      end

      it 'sends Game#switch_player once' do
        expect(play_game).to have_received(:switch_player).once
      end

      it 'sends Game#show_result once' do
        expect(play_game).to have_received(:show_result).once
      end
    end

    context 'when Game#over? is false 3 times' do
      before do
        allow(play_game).to receive(:over?).and_return(false, false, false, true)
        play_game.play
      end

      it 'sends Game#ensure_valid_turn 4 times' do
        expect(play_game).to have_received(:ensure_valid_turn).exactly(4).times
      end

      it 'sends Grid#insert 4 times' do
        expect(test_grid).to have_received(:insert).with(play_game.turn).exactly(4).times
      end

      it 'sends Game#switch_player 3 times' do
        expect(play_game).to have_received(:switch_player).exactly(3).times
      end

      it 'sends Game#show_result once' do
        expect(play_game).to have_received(:show_result).once
      end
    end
  end
end
