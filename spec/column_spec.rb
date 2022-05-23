require './lib/column'

describe Column do
  describe '#insert' do
    context 'when the column is empty' do
      subject(:empty_column) { described_class.new }

      before do
        marker = "\u26AA"
        empty_column.insert(marker)
      end

      it 'writes the player marker to the lowest available row' do
        expected = ["\u26AA", ' ', ' ', ' ', ' ', ' ']
        expect(empty_column.rows).to eql(expected)
      end

      it 'increments the lowest available row' do
        expect(empty_column.lowest_available).to be(1)
      end
    end
  end
end
