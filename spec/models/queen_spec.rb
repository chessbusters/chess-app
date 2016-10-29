require 'rails_helper'

RSpec.describe Queen, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the diagonal move is valid' do
      game = Game.create
      queen = game.pieces.where(color: 'white', type: 'Queen').first
      pawn = game.pieces.where(color: 'white', type: 'Pawn', x_coordinate: 3).first
      pawn.destroy
      puts queen.obstructed?(2, 2)
      expect(queen.valid_move?(2, 2)).to eq true
    end

    it 'should return true if the horizontal move is valid' do
      queen = Queen.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(queen.valid_move?(4, 3)).to eq true
      expect(queen.valid_move?(6, 3)).to eq true
      expect(queen.valid_move?(6, 4)).to eq false
    end

    it 'should return true if the vertical move is valid' do
      queen = Queen.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(queen.valid_move?(3, 2)).to eq true
      expect(queen.valid_move?(3, 6)).to eq true
      expect(queen.valid_move?(4, 6)).to eq false
    end
  end
end
