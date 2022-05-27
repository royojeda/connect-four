require './lib/grid'
require './lib/column'
require './lib/turn'

describe Grid do
  describe '#full?' do
    subject(:full_grid) { described_class.new(columns: Array.new(7, test_column)) }

    let(:test_column) { instance_double(Column) }

    context 'when all the @columns are full' do
      before do
        allow(test_column).to receive(:full?).and_return(true, true, true, true, true, true, true)
      end

      it 'returns true' do
        expect(full_grid.full?).to be(true)
      end
    end

    context 'when all the @columns are not full' do
      before do
        allow(test_column).to receive(:full?).and_return(false)
      end

      it 'returns false' do
        expect(full_grid.full?).to be(false)
      end
    end

    context 'when some of the @columns are full' do
      before do
        allow(test_column).to receive(:full?).and_return(true, true, true, false)
      end

      it 'returns false' do
        expect(full_grid.full?).to be(false)
      end
    end
  end

  describe '#fits?' do
    subject(:fits_grid) { described_class.new(columns: Array.new(7, test_column)) }

    let(:test_column) { instance_double(Column) }
    let(:test_turn) { instance_double(Turn) }

    context 'when the selected column is full' do
      before do
        selected_column = 7
        allow(test_turn).to receive(:move).and_return(selected_column)
        allow(test_column).to receive(:full?).and_return(true)
      end

      it 'returns false' do
        expect(fits_grid.fits?(test_turn)).to be(false)
      end
    end

    context 'when the selected column is not full' do
      before do
        selected_column = 7
        allow(test_turn).to receive(:move).and_return(selected_column)
        allow(test_column).to receive(:full?).and_return(false)
      end

      it 'returns true' do
        expect(fits_grid.fits?(test_turn)).to be(true)
      end
    end
  end
end
