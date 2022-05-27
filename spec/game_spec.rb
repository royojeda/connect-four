require './lib/game'
require './lib/grid'

describe Game do
  describe '#over?' do
    context 'when the @grid is full' do
      subject(:tied_game) { described_class.new(grid: full_grid) }

      let(:full_grid) { instance_double(Grid) }

      before do
        allow(full_grid).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        expect(tied_game.over?).to be(true)
      end
    end

    context 'when the @grid has four tokens connected' do
      subject(:won_game) { described_class.new(grid: connected_grid) }

      let(:connected_grid) { instance_double(Grid) }

      before do
        allow(connected_grid).to receive(:full?)
        allow(connected_grid).to receive(:four_connected?).and_return(true)
      end

      it 'returns true' do
        expect(won_game.over?).to be(true)
      end
    end

    context 'when the @grid is not full and no four tokens are connected' do
      subject(:ongoing_game) { described_class.new(grid: ongoing_grid) }

      let(:ongoing_grid) { instance_double(Grid) }

      before do
        allow(ongoing_grid).to receive(:full?).and_return(false)
        allow(ongoing_grid).to receive(:four_connected?).and_return(false)
      end

      it 'returns false' do
        expect(ongoing_game.over?).to be(false)
      end
    end
  end

  describe '#switch_player' do
    context 'when @current_player is player_one' do
      player_one = "\u26AA"
      player_two = "\u26AB"
      subject(:switch_game) { described_class.new(players: [player_one, player_two]) }

      it 'changes @current_player to player_two' do
        switch_game.switch_player
        expect(switch_game.current_player).to eq(player_two)
      end
    end

    context 'when @current_player is player_two' do
      player_one = "\u26AA"
      player_two = "\u26AB"
      subject(:switch_game) { described_class.new(players: [player_two, player_one]) }

      it 'changes @current_player to player_one' do
        switch_game.switch_player
        expect(switch_game.current_player).to eq(player_one)
      end
    end
  end

  describe '#show_result' do
    context 'when player_one is the winner' do
      subject(:one_game) { described_class.new(grid: test_grid) }

      let(:test_grid) { instance_double(Grid) }

      before do
        player_one = "\u26AA"
        allow(one_game).to receive(:current_player).and_return(player_one)
        allow(test_grid).to receive(:full?)
        allow(test_grid).to receive(:four_connected?).and_return(true)
      end

      it "prints a 'congratulations player one' message" do
        expected = "CONGRATULATIONS, player one! You've won the game"
        expect(one_game).to receive(:puts).with(expected)
        one_game.show_result
      end
    end

    context 'when player_two is the winner' do
      subject(:two_game) { described_class.new(grid: test_grid) }

      let(:test_grid) { instance_double(Grid) }

      before do
        player_two = "\u26AB"
        allow(two_game).to receive(:current_player).and_return(player_two)
        allow(test_grid).to receive(:full?)
        allow(test_grid).to receive(:four_connected?).and_return(true)
      end

      it "prints a 'congratulations player two' message" do
        expected = "CONGRATULATIONS, player two! You've won the game"
        expect(two_game).to receive(:puts).with(expected)
        two_game.show_result
      end
    end

    context 'when the game is tied' do
      subject(:tied_game) { described_class.new(grid: test_grid) }

      let(:test_grid) { instance_double(Grid) }

      before do
        allow(test_grid).to receive(:four_connected?).and_return(false)
      end

      it "prints a 'tied game' message" do
        expected = 'GAME OVER! The game ends in a draw.'
        expect(tied_game).to receive(:puts).with(expected)
        tied_game.show_result
      end
    end
  end
end
