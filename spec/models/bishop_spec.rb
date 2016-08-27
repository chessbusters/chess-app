require 'rails_helper'

RSpec.describe Bishop, type: :pieces do
  describe 'valid_move?' do
    it 'should return true if the diagonal move is valid' do
      bishop = Bishop.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(bishop.valid_move?(6, 6)).to eq true
    end
  end
end
