require './lib/player'

describe Player do
  describe '#play' do
    subject(:player) { described_class.new }

    context 'when the input is between 1 and 7' do
      before do
        input = '5'
        allow(player).to receive(:gets).and_return(input)
      end

      it 'writes input to @move' do
        player.play
        expect(player.move).to eq(5)
      end
    end

    context 'when the input is not between 1 and 7' do
      before do
        input = '8'
        allow(player).to receive(:gets).and_return(input)
      end

      it "doesn't change @move" do
        expect { player.play }.not_to(change(player, :move))
      end
    end

    context 'when the input is not an integer' do
      before do
        input = 'a'
        allow(player).to receive(:gets).and_return(input)
      end

      it "doesn't change @move" do
        expect { player.play }.not_to(change(player, :move))
      end
    end
  end
end
