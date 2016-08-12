# model for games
class Game < ActiveRecord::Base
  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  has_many :pieces
  delegate :bishops, :rooks, :pawns, :kings, :queens, :knights, to: :pieces

  def populate_board!
    King.create(game: self, color:  x_coordinate:, y_coordinate: )

  end

  def create_piece
    Pawn.create.....

  end


  def white_pawn
    (0..7).each do |x|
      Pawn.create(
      game_id = id;
      x_coordinate = x;
      y_coordinate = 1;)
    end
  end

  def black_pawn
    (0..7).each do |x|
      Pawn.create(
      game_id = id;
      x_coordinate = x;
      y_coordinate = 6;)
    end
  end

# YOU NEED TO DO A MIGRATION FOR PIECE COLOR 






end
