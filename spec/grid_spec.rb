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

    before do
      allow(test_turn).to receive(:error=)
    end

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

  describe '#insert' do
    subject(:insert_grid) { described_class.new(columns: Array.new(7, test_column)) }

    let(:test_column) { instance_double(Column) }
    let(:test_turn) { instance_double(Turn, move: 7, player: "\u26AA") }

    before do
      allow(test_column).to receive(:drop_in)
      insert_grid.insert(test_turn)
    end

    it 'sends #drop_in to the selected column' do
      expect(test_column).to have_received(:drop_in).with("\u26AA").once
    end
  end

  describe '#four_horizontal?' do
    context 'when the grid has 4 connected tokens in the first row' do
      subject(:horizontal_grid) { described_class.new(columns: [test_column1, test_column2, test_column3, test_column4, test_column5, test_column6, test_column7]) }

      token = "\u26AB"
      empty = '  '

      let(:test_column1) { instance_double(Column, rows: [token, empty, empty, empty, empty, empty]) }
      let(:test_column2) { instance_double(Column, rows: [token, empty, empty, empty, empty, empty]) }
      let(:test_column3) { instance_double(Column, rows: [token, empty, empty, empty, empty, empty]) }
      let(:test_column4) { instance_double(Column, rows: [token, empty, empty, empty, empty, empty]) }
      let(:test_column5) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column6) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column7) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }

      it 'returns true' do
        expect(horizontal_grid.four_horizontal?).to be(true)
      end
    end

    context 'when the grid has 4 connected tokens in the 5th row' do
      subject(:horizontal_grid) { described_class.new(columns: [test_column1, test_column2, test_column3, test_column4, test_column5, test_column6, test_column7]) }

      token = "\u26AB"
      empty = '  '

      let(:test_column1) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column2) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column3) { instance_double(Column, rows: [empty, empty, empty, empty, token, empty]) }
      let(:test_column4) { instance_double(Column, rows: [empty, empty, empty, empty, token, empty]) }
      let(:test_column5) { instance_double(Column, rows: [empty, empty, empty, empty, token, empty]) }
      let(:test_column6) { instance_double(Column, rows: [empty, empty, empty, empty, token, empty]) }
      let(:test_column7) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }

      it 'returns true' do
        expect(horizontal_grid.four_horizontal?).to be(true)
      end
    end

    context 'when the grid does not have 4 connected tokens in all rows' do
      subject(:horizontal_grid) { described_class.new(columns: [test_column1, test_column2, test_column3, test_column4, test_column5, test_column6, test_column7]) }

      token = "\u26AB"
      empty = '  '

      let(:test_column1) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column2) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column3) { instance_double(Column, rows: [empty, token, empty, empty, empty, empty]) }
      let(:test_column4) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column5) { instance_double(Column, rows: [empty, token, empty, empty, empty, empty]) }
      let(:test_column6) { instance_double(Column, rows: [empty, token, empty, empty, empty, empty]) }
      let(:test_column7) { instance_double(Column, rows: [empty, token, empty, empty, empty, empty]) }

      it 'returns false' do
        expect(horizontal_grid.four_horizontal?).to be(false)
      end
    end
  end

  describe '#four_vertical?' do
    context 'when the grid has 4 connected tokens in the first column' do
      subject(:vertical_grid) { described_class.new(columns: [test_column1, test_column2, test_column3, test_column4, test_column5, test_column6, test_column7]) }

      token = "\u26AB"
      empty = '  '

      let(:test_column1) { instance_double(Column, rows: [token, token, token, token, empty, empty]) }
      let(:test_column2) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column3) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column4) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column5) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column6) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column7) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }

      it 'returns true' do
        expect(vertical_grid.four_vertical?).to be true
      end
    end

    context 'when the grid has 4 connected tokens in the 5th column' do
      subject(:vertical_grid) { described_class.new(columns: [test_column1, test_column2, test_column3, test_column4, test_column5, test_column6, test_column7]) }

      token = "\u26AB"
      empty = '  '

      let(:test_column1) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column2) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column3) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column4) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column5) { instance_double(Column, rows: [empty, token, token, token, token, empty]) }
      let(:test_column6) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column7) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }

      it 'returns true' do
        expect(vertical_grid.four_vertical?).to be true
      end
    end

    context 'when the grid has does not have 4 connected tokens in the all columns' do
      subject(:vertical_grid) { described_class.new(columns: [test_column1, test_column2, test_column3, test_column4, test_column5, test_column6, test_column7]) }

      token = "\u26AB"
      empty = '  '

      let(:test_column1) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column2) { instance_double(Column, rows: [empty, token, empty, token, token, token]) }
      let(:test_column3) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column4) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column5) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column6) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }
      let(:test_column7) { instance_double(Column, rows: [empty, empty, empty, empty, empty, empty]) }

      it 'returns false' do
        expect(vertical_grid.four_vertical?).to be false
      end
    end
  end
end
