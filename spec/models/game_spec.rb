require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate board' do
    it 'should populate the board with 32 pieces' do
      game = Game.create
      expect(game.pieces.count).to eq 32
    end
  end

  describe 'king in check' do
    it 'should return false when the board is created' do
      game = Game.create
      expect(game.check?('white')).to eq false
    end
    it 'should return true if the king is in check' do
      game = Game.create
      white_king = King.where(game: game, color: 'white').first
      black_queen = Queen.where(game: game, color: 'black').first
      white_king.x_coordinate = 4
      white_king.y_coordinate = 4
      white_king.save
      black_queen.x_coordinate = 4
      black_queen.y_coordinate = 5
      black_queen.save
      expect(game.check?('white')).to eq true
    end
  end
end
