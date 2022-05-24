require './lib/player'

describe Player do
  describe '#play' do
    subject(:player) { described_class.new }

    before do
      input = '5'
      allow(player).to receive(:gets).and_return(input)
    end

    it 'writes input to @move' do
      player.play
      expect(player.move).to eq(5)
    end
  end
end
