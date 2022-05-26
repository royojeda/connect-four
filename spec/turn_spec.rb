require './lib/turn'

describe Turn do
  describe '#prompt_input' do
    subject(:input_turn) { described_class.new }

    context "when the user inputs '7'" do
      before do
        user_input = '7'
        allow(input_turn).to receive(:gets).and_return(user_input)
      end

      it 'stores 7 to @move' do
        input_turn.prompt_input
        expect(input_turn.move).to eq(7)
      end
    end

    context "when the user inputs '3'" do
      before do
        user_input = '3'
        allow(input_turn).to receive(:gets).and_return(user_input)
      end

      it 'stores 3 to @move' do
        input_turn.prompt_input
        expect(input_turn.move).to eq(3)
      end
    end

    context 'when the user inputs a non-integer number' do
      before do
        user_input = '5.1'
        allow(input_turn).to receive(:gets).and_return(user_input)
      end

      it 'stores the rounded-off integer to @move' do
        input_turn.prompt_input
        expect(input_turn.move).to eq(5)
      end
    end

    context 'when the user inputs not a number' do
      before do
        user_input = 'a'
        allow(input_turn).to receive(:gets).and_return(user_input)
      end

      it 'stores 0 to @move' do
        input_turn.prompt_input
        expect(input_turn.move).to eq(0)
      end
    end
  end
end
