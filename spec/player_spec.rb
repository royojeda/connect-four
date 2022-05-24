require './lib/player'

describe Player do
  mark = "\u26AA"
  subject(:player) { described_class.new(mark: mark) }

  describe '#play' do

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

  describe '#mark' do
    it "returns the player's mark" do
      expect(player.mark).to eq("\u26AA")
    end
  end
end
