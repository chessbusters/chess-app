require 'rails_helper'

describe Piece do
  
  describe ".is_obstructed?" do
    it 'should return error on illegal move' do
      piece = Piece.create(
        x_coordinate: 3,
        y_coordinate: 3)  
      expect(piece.is_obstructed?(1, 4)).to eq("Invalid Input: Not diagonal, horizontal, or vertical.")
    end
    
    it 'should return true if obstructed diagonally' do
      game = Game.create()
      piece = Piece.create( 
        game: game,
        x_coordinate: 3,
        y_coordinate: 3)
      piece_up = Piece.create(
        game: game,
        x_coordinate: 5,
        y_coordinate: 5) 
      piece_down = Piece.create(
        game: game,
        x_coordinate: 2,
        y_coordinate: 2)
      
      expect(piece.is_obstructed?(6,6)).to eq(true)
      expect(piece.is_obstructed?(0,0)).to eq(true)
    end
    
    it 'should return true if obstructed horizontally' do
      game = Game.create()
      piece = Piece.create( 
        game: game,
        x_coordinate: 3,
        y_coordinate: 3)
      piece_up = Piece.create(
        game: game,
        x_coordinate: 5,
        y_coordinate: 3) 
      piece_down = Piece.create(
        game: game,
        x_coordinate: 2,
        y_coordinate: 3)
      
      expect(piece.is_obstructed?(6,3)).to eq(true)
      expect(piece.is_obstructed?(0,3)).to eq(true)
    end
    
    it 'should return true if obstructed vertically' do
      game = Game.create()
      piece = Piece.create( 
        game: game,
        x_coordinate: 3,
        y_coordinate: 3)
      piece_up = Piece.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 5) 
      piece_down = Piece.create(
        game: game,
        x_coordinate: 3,
        y_coordinate: 2)
      
      expect(piece.is_obstructed?(3,6)).to eq(true)
      expect(piece.is_obstructed?(3,0)).to eq(true)
    end
  end
  
end