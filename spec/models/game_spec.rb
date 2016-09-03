require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate board' do
    it 'should populate the board with 32 pieces' do
      game = Game.create
      expect(game.pieces.count).to eq 32
    end

    it 'should support castling' do
      game = Game.create
      white_king = King.find_by(game: game, color: 'white')
      white_king.move_to!(5, 4)
      white_king.save
      puts game.black_castling
      puts game.white_castling
      white_king.save
      expect(game.valid_castling_move?("white", "king_side")).to eq false
    end
  end
end
