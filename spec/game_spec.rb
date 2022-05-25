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

  describe '#wait_for_valid_input' do
    subject(:valid_game) { described_class.new }

    context 'when @input is within range' do
      it 'sends #accept_input once' do
        allow(valid_game).to receive(:within_range?).and_return(true)
        expect(valid_game).to receive(:accept_input).once
        valid_game.wait_for_valid_input
      end
    end

    context 'when @input is out of range once' do
      it 'sends #accept_input twice' do
        allow(valid_game).to receive(:within_range?).and_return(false, true)
        expect(valid_game).to receive(:accept_input).twice
        valid_game.wait_for_valid_input
      end
    end

    context 'when @input is out of range 3 times' do
      it 'sends #accept_input 4 times' do
        allow(valid_game).to receive(:within_range?).and_return(false, false, false, true)
        expect(valid_game).to receive(:accept_input).exactly(4).times
        valid_game.wait_for_valid_input
      end
    end
  end
end
