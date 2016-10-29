require 'rails_helper'

RSpec.describe Bishop, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the diagonal move is valid' do
      game = Game.create
      bishop = game.pieces.where(color: 'white', type: 'Bishop', x_coordinate: 5).first
      expect(bishop.valid_move?(3, 2)).to eq true
    end
  end
end
