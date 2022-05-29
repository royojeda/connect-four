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

  describe '#display' do
    subject(:display_grid) { described_class.new(columns: Array.new(7, test_column)) }

    let(:test_column) { instance_double(Column) }

    it 'prints the current condition of the grid' do
      expected = <<~TEXT
        \u250C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u252C\u2500\u2500\u2500\u2500\u2510
        \u2502 #{columns[0].rows[5]} \u2502 #{columns[1].rows[5]} \u2502 #{columns[2].rows[5]} \u2502 #{columns[3].rows[5]} \u2502 #{columns[4].rows[5]} \u2502 #{columns[5].rows[5]} \u2502 #{columns[6].rows[5]} \u2502
        \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
        \u2502 #{columns[0].rows[4]} \u2502 #{columns[1].rows[4]} \u2502 #{columns[2].rows[4]} \u2502 #{columns[3].rows[4]} \u2502 #{columns[4].rows[4]} \u2502 #{columns[5].rows[4]} \u2502 #{columns[6].rows[4]} \u2502
        \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
        \u2502 #{columns[0].rows[3]} \u2502 #{columns[1].rows[3]} \u2502 #{columns[2].rows[3]} \u2502 #{columns[3].rows[3]} \u2502 #{columns[4].rows[3]} \u2502 #{columns[5].rows[3]} \u2502 #{columns[6].rows[3]} \u2502
        \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
        \u2502 #{columns[0].rows[2]} \u2502 #{columns[1].rows[2]} \u2502 #{columns[2].rows[2]} \u2502 #{columns[3].rows[2]} \u2502 #{columns[4].rows[2]} \u2502 #{columns[5].rows[2]} \u2502 #{columns[6].rows[2]} \u2502
        \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
        \u2502 #{columns[0].rows[1]} \u2502 #{columns[1].rows[1]} \u2502 #{columns[2].rows[1]} \u2502 #{columns[3].rows[1]} \u2502 #{columns[4].rows[1]} \u2502 #{columns[5].rows[1]} \u2502 #{columns[6].rows[1]} \u2502
        \u251C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u253C\u2500\u2500\u2500\u2500\u2524
        \u2502 #{columns[0].rows[0]} \u2502 #{columns[1].rows[0]} \u2502 #{columns[2].rows[0]} \u2502 #{columns[3].rows[0]} \u2502 #{columns[4].rows[0]} \u2502 #{columns[5].rows[0]} \u2502 #{columns[6].rows[0]} \u2502
        \u2514\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2534\u2500\u2500\u2500\u2500\u2518

      TEXT

      expect { display_grid.display }.to output(expected).to_stdout
    end
  end
end
