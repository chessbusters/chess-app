require 'rails_helper'

RSpec.describe Knight, type: :pieces do
  describe 'valid_move?' do
    it 'should fail if not an L-shaped move' do
      knight = Knight.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(knight.valid_move?(2, 2)).to eq(false)
      expect(knight.valid_move?(6, 3)).to eq(false)
      expect(knight.valid_move?(1, 2)).to eq(true)
      expect(knight.valid_move?(4, 5)).to eq(true)
    end
  end
end
