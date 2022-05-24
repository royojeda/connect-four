require './lib/column'

describe Column do
  describe '#insert' do
    context 'when the column is empty' do
      marker = "\u26AA"
      starting_rows = [' ', ' ', ' ', ' ', ' ', ' ']
      starting_lowest_available = 0

      subject(:empty_column) { described_class.new(lowest_available: starting_lowest_available, rows: starting_rows) }

      before do
        empty_column.insert(marker)
      end

      it 'writes the player marker to the lowest available row' do
        expected = [marker, ' ', ' ', ' ', ' ', ' ']
        expect(empty_column.rows).to eql(expected)
      end

      it 'increments the lowest available row' do
        expect(empty_column.lowest_available).to be(starting_lowest_available + 1)
      end
    end

    context 'when the column is not empty' do
      marker = "\u26AB"
      starting_rows = [marker, marker, marker, ' ', ' ', ' ']
      starting_lowest_available = 3

      subject(:non_empty_column) do
        described_class.new(lowest_available: starting_lowest_available, rows: starting_rows)
      end

      before do
        non_empty_column.insert(marker)
      end

      it 'writes the player marker to the lowest available row' do
        expected = [marker, marker, marker, marker, ' ', ' ']
        expect(non_empty_column.rows).to eql(expected)
      end

      it 'increments the lowest available row' do
        expect(non_empty_column.lowest_available).to be(starting_lowest_available + 1)
      end
    end
  end
end
