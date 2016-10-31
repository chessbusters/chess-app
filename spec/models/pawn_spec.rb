require 'rails_helper'

RSpec.describe Pawn, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the upfront move is valid' do
      game = Game.create
      pawn = game.pieces.where(color: 'black', type: 'Pawn', x_coordinate: 2).first
      expect(pawn.valid_move?(2, 4)).to eq true
    end

    # it 'should return true if the pawn can perform a double jump' do
    #   white_pawn = Pawn.create(
    #     x_coordinate: 1,
    #     y_coordinate: 1,
    #     color: 'white'
    #   )
    #   black_pawn = Pawn.create(
    #     x_coordinate: 6,
    #     y_coordinate: 6,
    #     color: 'black'
    #   )
    #   expect(white_pawn.valid_move?(1, 2)).to eq true
    #   expect(white_pawn.valid_move?(1, 3)).to eq true
    #   expect(white_pawn.valid_move?(1, 4)).to eq false
    #   expect(white_pawn.valid_move?(1, 0)).to eq false

    #   expect(black_pawn.valid_move?(6, 5)).to eq true
    #   expect(black_pawn.valid_move?(6, 4)).to eq true
    #   expect(black_pawn.valid_move?(6, 3)).to eq false
    #   expect(black_pawn.valid_move?(6, 7)).to eq false
    # end
  end
end
