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

    it 'should not castling if king moved' do
      game = Game.create(name: 'hey')
      king = King.where(game: game, color: 'white', x_coordinate: 3).first
      king.move_to!(5, 4)
      expect(game.valid_castling_move?('white', 'king_side')).to eq false
    end

    it 'should not castling from king side color: white if path is not clear' do
      game = Game.create(name: 'hey')
      knight = Knight.where(game: game, color: 'white', x_coordinate: 1).first
      knight.move_to!(1, 2)
      expect(game.valid_castling_move?('white', 'king_side')).to eq false
    end

    it 'should allow castling from king side color: white' do
      game = Game.create(name: 'hey')
      bishop = Bishop.where(game: game, color: 'white', x_coordinate: 2).first
      knight = Knight.where(game: game, color: 'white', x_coordinate: 1).first
      knight.move_to!(1, 2)
      bishop.move_to!(0, 2)
      expect(game.valid_castling_move?('white', 'king_side')).to eq true
    end

    it 'should allow castling from queen side color: black' do
      game = Game.create(name: 'hey')
      bishop = Bishop.where(game: game, color: 'black', x_coordinate: 5).first
      knight = Knight.where(game: game, color: 'black', x_coordinate: 6).first
      queen = Queen.where(game: game, color: 'black').first
      queen.move_to!(4, 4)
      knight.move_to!(6, 5)
      bishop.move_to!(7, 5)
      expect(game.valid_castling_move?('black', 'queen_side')).to eq true
    end

    it 'should allow castling from king side color: black' do
      game = Game.create(name: 'hey')
      bishop = Bishop.where(game: game, color: 'black', x_coordinate: 2).first
      knight = Knight.where(game: game, color: 'black', x_coordinate: 1).first
      knight.move_to!(2, 5)
      bishop.move_to!(0, 5)
      expect(game.valid_castling_move?('black', 'king_side')).to eq true
    end
  end
end
