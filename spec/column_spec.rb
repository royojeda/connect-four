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

    context 'when the @rows are partially filled' do
      token = "\u26AA"
      subject(:partial_column) { described_class.new(rows: [token, token, ' ', ' ', ' ', ' ']) }

      it 'returns false' do
        expect(partial_column.full?).to be(false)
      end
    end
  end

  describe '#lowest_available' do
    context 'when @rows are empty' do
      token = ' '
      subject(:empty_column) { described_class.new(rows: Array.new(6, token)) }

      it 'returns 0' do
        expect(empty_column.lowest_available).to eq(0)
      end
    end

    context 'when @rows are full' do
      token = "\u26AA"
      subject(:full_column) { described_class.new(rows: Array.new(6, token)) }

      it 'returns nil' do
        expect(full_column.lowest_available).to be_nil
      end
    end

    context 'when the @rows have 3 player tokens' do
      token = "\u26AA"
      subject(:partial_column) { described_class.new(rows: [token, token, token, ' ', ' ', ' ']) }

      it 'returns 3' do
        expect(partial_column.lowest_available).to eq(3)
      end
    end
  end
end
