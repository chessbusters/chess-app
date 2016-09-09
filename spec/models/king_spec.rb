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

    it 'should not castling' do
      game = Game.create(name: 'hey')
      white_king = King.where(game: game, color: 'white', x_coordinate: 3).first
      white_king.move_to!(5, 4)
      expect(game.valid_castling_move?('white', 'king_side')).to eq false
    end

    it 'should allow castling' do
      game = Game.create(name: 'hey')
      white_king = King.where(game: game, color: 'white', x_coordinate: 3).first
      white_bishop = Bishop.where(game: game, color: 'white', x_coordinate: 2).first
      white_knight = Knight.where(game: game, color: 'white', x_coordinate: 1).first
      white_knight.move_to!(1, 2)
      white_bishop.move_to!(0, 2)
      expect(game.valid_castling_move?('white', 'king_side')).to eq true
    end

  end
end
