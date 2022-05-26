require './lib/column'

describe Column do
  describe '#full?' do
    context 'when the @rows are full' do
      token = "\u26AA"
      initial_rows = Array.new(6, token)
      subject(:full_column) { described_class.new(rows: initial_rows) }

      it 'returns true' do
        expect(full_column.full?).to be(true)
      end
    end

    context 'when the @rows are empty' do
      token = ' '
      initial_rows = Array.new(6, token)
      subject(:empty_column) { described_class.new(rows: initial_rows) }

      it 'returns false' do
        expect(empty_column.full?).to be(false)
      end
    end

    context 'when the @rows are partially filled' do
      token = "\u26AA"
      initial_rows = [token, token, ' ', ' ', ' ', ' ']
      subject(:partial_column) { described_class.new(rows: initial_rows) }

      it 'returns false' do
        expect(partial_column.full?).to be(false)
      end
    end
  end

  describe '#lowest_available' do
    context 'when @rows are empty' do
      token = ' '
      initial_rows = Array.new(6, token)
      subject(:empty_column) { described_class.new(rows: initial_rows) }

      it 'returns 0' do
        expect(empty_column.lowest_available).to eq(0)
      end
    end

    context 'when @rows are full' do
      token = "\u26AA"
      initial_rows = Array.new(6, token)
      subject(:full_column) { described_class.new(rows: initial_rows) }

      it 'returns nil' do
        expect(full_column.lowest_available).to be_nil
      end
    end

    context 'when the @rows have 3 player tokens' do
      token = "\u26AA"
      initial_rows = [token, token, token, ' ', ' ', ' ']
      subject(:partial_column) { described_class.new(rows: initial_rows) }

      it 'returns 3' do
        expect(partial_column.lowest_available).to eq(3)
      end
    end
  end

  describe '#drop_in' do
    context 'when the Column is not full' do
      token = "\u26AA"
      initial_rows = [token, token, ' ', ' ', ' ', ' ']
      subject(:droppable_column) { described_class.new(rows: initial_rows) }

      it 'stores the player token to the lowest available row' do
        expected_rows = [token, token, token, ' ', ' ', ' ']
        expect { droppable_column.drop_in(token) }.to change(droppable_column, :rows).to(expected_rows)
      end
    end

    context 'when the Column is full' do
      token = "\u26AA"
      initial_rows = [token, token, token, token, token, token]
      subject(:undroppable_column) { described_class.new(rows: initial_rows) }

      it 'does nothing to the @rows' do
        expect { undroppable_column.drop_in(token) }.not_to(change(undroppable_column, :rows))
      end
    end
  end
end
