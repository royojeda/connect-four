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
end
