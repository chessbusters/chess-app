require 'rails_helper'

RSpec.describe Pawn, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the upfront move is valid' do
      pawn = Pawn.create(
        x_coordinate: 3,
        y_coordinate: 3,
        color: 'white'
      )
      expect(pawn.valid_move?(3, 4)).to eq true
      expect(pawn.valid_move?(3, 6)).to eq false
      expect(pawn.valid_move?(3, 2)).to eq false
    end

    it 'should return true if the pawn can perform a double jump' do
      white_pawn = Pawn.create(
        x_coordinate: 1,
        y_coordinate: 1,
        color: 'white'
      )
      black_pawn = Pawn.create(
        x_coordinate: 6,
        y_coordinate: 6,
        color: 'black'
      )
      expect(white_pawn.valid_move?(1, 2)).to eq true
      expect(white_pawn.valid_move?(1, 3)).to eq true
      expect(white_pawn.valid_move?(1, 4)).to eq false
      expect(white_pawn.valid_move?(1, 0)).to eq false

      expect(black_pawn.valid_move?(6, 5)).to eq true
      expect(black_pawn.valid_move?(6, 4)).to eq true
      expect(black_pawn.valid_move?(6, 3)).to eq false
      expect(black_pawn.valid_move?(6, 7)).to eq false
    end
  end
end
