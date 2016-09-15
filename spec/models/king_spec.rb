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

    it 'should return false if it moves itself into check' do
      game = Game.create
      white_king = King.where(game: game, color: 'white').first
      black_queen = Queen.where(game: game, color: 'black').first
      white_king.x_coordinate = 3
      white_king.y_coordinate = 3
      white_king.save
      black_queen.x_coordinate = 4
      black_queen.y_coordinate = 6
      black_queen.save
      expect(white_king.valid_move?(3, 4)).to eq true
      expect(white_king.valid_move?(4, 3)).to eq false
    end

  end
end
