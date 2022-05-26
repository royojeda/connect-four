require './lib/column'

describe Column do
  describe '#full?' do
    context 'when the @rows are full' do
      token = "\u26AA"
      subject(:full_column) { described_class.new(rows: Array.new(6, token)) }

      it 'returns true' do
        expect(full_column.full?).to be(true)
      end
    end

    context 'when the @rows are empty' do
      token = ' '
      subject(:empty_column) { described_class.new(rows: Array.new(6, token)) }

      it 'returns false' do
        expect(empty_column.full?).to be(false)
      end
    end

    context 'when the @rows partially filled' do
      token = "\u26AA"
      subject(:partial_column) { described_class.new(rows: [token, token, ' ', ' ', ' ', token]) }

      it 'returns false' do
        expect(partial_column.full?).to be(false)
      end
    end
  end
end
