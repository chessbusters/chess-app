require 'rails_helper'

RSpec.describe Rook, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the horizontal move' do
      rook = Rook.create(
        x_coordinate: 2,
        y_coordinate: 2
      )
      expect(rook.valid_move?(2, 4)).to eq true
    end

    it 'should return fale if the diagal move' do
      rook = Rook.create(
        x_coordinate: 2,
        y_coordinate: 2
      )
      expect(rook.valid_move?(3, 3)).to eq false
    end

    it 'should return true if the vertial move' do
      rook = Rook.create(
        x_coordinate: 2,
        y_coordinate: 2
      )
      expect(rook.valid_rook_range?(2, 3)).to eq true
    end
  end
end
