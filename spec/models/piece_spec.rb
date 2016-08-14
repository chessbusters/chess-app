require 'rails_helper'

describe Piece do
  describe '.obstructed?' do
    it 'should return error on illegal move' do
      piece = Piece.create(
        x_coordinate: 3,
        y_coordinate: 3
      )
      expect(piece.obstructed?(1, 4)).to eq(
        'Invalid Input: Not diagonal, horizontal, or vertical.'
      )
    end

    it 'should return true if obstructed diagonally' do
      game = Game.create
      piece = Piece.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 3
      )
      game.pieces.create(
        game: game,
        x_coordinate: 5,
        y_coordinate: 5
      )
      game.pieces.create(
        game: game,
        x_coordinate: 2,
        y_coordinate: 2
      )

      expect(piece.obstructed?(6, 6)).to eq(true)
      expect(piece.obstructed?(0, 0)).to eq(true)
      expect(piece.obstructed?(5, 5)).to eq(false)
      expect(piece.obstructed?(2, 2)).to eq(false)
    end

    it 'should return true if obstructed horizontally' do
      game = Game.create
      piece = Piece.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 3
      )
      game.pieces.create(
        game: game,
        x_coordinate: 5,
        y_coordinate: 3
      )
      game.pieces.create(
        game: game,
        x_coordinate: 2,
        y_coordinate: 3
      )

      expect(piece.obstructed?(6, 3)).to eq(true)
      expect(piece.obstructed?(0, 3)).to eq(true)
      expect(piece.obstructed?(5, 3)).to eq(false)
      expect(piece.obstructed?(2, 3)).to eq(false)
    end

    it 'should return true if obstructed vertically' do
      game = Game.create
      piece = Piece.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 3
      )
      game.pieces.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 5
      )
      game.pieces.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 2
      )

      expect(piece.obstructed?(3, 6)).to eq(true)
      expect(piece.obstructed?(3, 0)).to eq(true)
      expect(piece.obstructed?(3, 5)).to eq(false)
      expect(piece.obstructed?(3, 2)).to eq(false)
    end
  end
end
