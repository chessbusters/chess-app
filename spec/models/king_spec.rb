require 'rails_helper'

RSpec.describe King, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the diagonal move is valid' do
      king = King.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(king.valid_move?(4, 4)).to eq true
    end

    it 'should return true if the horizontal move is valid' do
      king = King.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(king.valid_move?(4, 3)).to eq true
    end

    it 'should return true if the vertical move is valid' do
      king = King.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(king.valid_move?(3, 2)).to eq true
    end
  end
end
