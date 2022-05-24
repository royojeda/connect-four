require './lib/grid'

describe Grid do
  describe '#full?' do
    context 'when the grid is full' do
      subject(:full_grid) { described_class.new(columns: Array.new(7, Column.new(rows: Array.new(6, 'B')))) }

      it 'returns true' do
        expect(full_grid.full?).to be(true)
      end
    end

    context 'when the grid is not full' do
      subject(:full_grid) { described_class.new }

      it 'returns false' do
        expect(full_grid.full?).to be(false)
      end
    end
  end
end
