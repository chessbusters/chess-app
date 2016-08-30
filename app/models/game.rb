# model for games
class Game < ActiveRecord::Base
  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  has_many :pieces
  belongs_to :user
  delegate :bishops, :rooks, :pawns, :kings, :queens, :knights, to: :pieces

  after_create :populate_board!

  def populate_board!
    create_king
    create_queen
    create_bishop
    create_knight
    create_rook
    create_white_pawn
    create_black_pawn
  end

  def create_king
    King.create(game: self, color: 'white', x_coordinate: 3, y_coordinate: 0)
    King.create(game: self, color: 'black', x_coordinate: 3, y_coordinate: 7)
  end

  def create_queen
    Queen.create(game: self, color: 'white', x_coordinate: 4, y_coordinate: 0)
    Queen.create(game: self, color: 'black', x_coordinate: 4, y_coordinate: 7)
  end

  def create_bishop
    Bishop.create(game: self, color: 'white', x_coordinate: 2, y_coordinate: 0)
    Bishop.create(game: self, color: 'white', x_coordinate: 5, y_coordinate: 0)
    Bishop.create(game: self, color: 'black', x_coordinate: 2, y_coordinate: 7)
    Bishop.create(game: self, color: 'black', x_coordinate: 5, y_coordinate: 7)
  end

  def create_knight
    Knight.create(game: self, color: 'white', x_coordinate: 1, y_coordinate: 0)
    Knight.create(game: self, color: 'white', x_coordinate: 6, y_coordinate: 0)
    Knight.create(game: self, color: 'black', x_coordinate: 1, y_coordinate: 7)
    Knight.create(game: self, color: 'black', x_coordinate: 6, y_coordinate: 7)
  end

  def create_rook
    Rook.create(game: self, color: 'white', x_coordinate: 0, y_coordinate: 0)
    Rook.create(game: self, color: 'white', x_coordinate: 7, y_coordinate: 0)
    Rook.create(game: self, color: 'black', x_coordinate: 0, y_coordinate: 7)
    Rook.create(game: self, color: 'black', x_coordinate: 7, y_coordinate: 7)
  end

  def create_white_pawn
    (0..7).each do |x|
      Pawn.create(
        game: self,
        color: 'white',
        x_coordinate: x,
        y_coordinate: 1
      )
    end
  end

  def create_black_pawn
    (0..7).each do |x|
      Pawn.create(
        game: self,
        color: 'black',
        x_coordinate: x,
        y_coordinate: 6
      )
    end
  end

  def white_king_side
    if valid_castling_move?("white", "king_side")
    end
  end

  def black_king_side
    if valid_castling_move?("black", "king_side")
    end
  end

  def white_queen_side
    if valid_castling_move?("white", "queen_side")
    end
  end

  def black_queen_side
    if valid_castling_move?("black", "queen_side")
    end
  end

  private 

  def valid_castling_move?(color, side)
    if color == "white" 
     y_coordinate = 0 
     valid_castling = game.white_castling
    else
      y_coordinate = 7
    valid_castling = game.black_castling
    end
    new_x = side == "king_side" ? 6 : 1
    king = game.pieces.where(x_coordinate: 4, y_coordinate: y_coordinate)
    return false if king.obstructed?(new_x, y_coordinate) && !valid_castling
    true
  end
end
