require './lib/game'

describe Game do
  describe '#accept_input' do
    subject(:input_game) { described_class.new }

    context 'when given an integer input' do
      it 'writes the integer value of the input to @input' do
        input = '3'
        allow(input_game).to receive(:gets).and_return(input)
        input_game.accept_input
        expect(input_game.input).to eql(input.to_i)
      end
    end

    context 'when given a string input' do
      it 'writes 0 to @input' do
        input = 'a'
        allow(input_game).to receive(:gets).and_return(input)
        input_game.accept_input
        expect(input_game.input).to be(0)
      end
    end
  end

  describe '#within_range?' do
    context 'when @input is between 1 and 7 (inclusive)' do
      subject(:range_game) { described_class.new(input: 5) }

      it 'returns true' do
        expect(range_game.within_range?).to be(true)
      end
    end


    context 'when @input is not between 1 and 7 (inclusive)' do
      subject(:range_game) { described_class.new(input: 50) }

      it 'returns true' do
        expect(range_game.within_range?).to be(false)
      end
    end
  end
end
