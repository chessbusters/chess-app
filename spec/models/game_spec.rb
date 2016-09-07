require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate board' do
    it 'should populate the board with 32 pieces' do
      game = Game.create
      expect(game.pieces.count).to eq 32
    end

  end
end
