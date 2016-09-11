# rubocop:disable ClassLength
# model for games
class Game < ActiveRecord::Base
  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  has_many :pieces, autosave: true
  belongs_to :user
  delegate :bishops, :rooks, :pawns, :kings, :queens, :knights, to: :pieces

  after_create :populate_board!

  # rubocop:disable Metrics/MethodLength
  def populate_board!
    create_king
    create_queen
    create_bishop
    create_knight
    create_rook
    create_white_pawn
    create_black_pawn
  end

  def check?(color)
    king = King.where(game: self, color: color).first
    opposing_pieces = Piece.where(game: self).where.not(color: color)
    opposing_pieces.each do |piece|
      return true if piece.valid_move?(king.x_coordinate, king.y_coordinate)
    end
    false
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

  # rubocop:disable CyclomaticComplexity, PerceivedComplexity

  ########### CASTLING METHODS

  # Validate castling
  def valid_castling_move?(color, side)
    new_y, new_rook_x, new_king_x = new_positions(color, side)
    rook, king = select_rook_and_king(color, side)
    return true if !king_not_moved?(king, color) && \
                   !king.obstructed?(new_king_x, new_y) \
    && !rook.obstructed?(new_rook_x, new_y)
    false
  end

  # Determines if the king has moved
  def king_not_moved?(king, color)
    if king.x_coordinate != 3 && king.y_coordinate.nonzero?  \
    && color == 'white'
      update_attributes(white_castling: true)
      true
    elsif king.x_coordinate != 3 && king.y_coordinate != 7  \
    && color == 'black'
      update_attributes(black_castling: true)
      true
    else
      return false
    end
  end

  # set the new positions for king and rook after castling complete
  def new_positions(color, side)
    new_y = color == 'white' ? 0 : 7
    new_rook_x = side == 'king_side' ? 2 : 4
    new_king_x = side == 'king_side' ? 1 : 5
    [new_y, new_rook_x, new_king_x]
  end

  # Select the right rook for castling
  def which_rook(color, side)
    if side == 'king_side'
      return pieces.find_by(game: self, \
                            color: color, type: 'Rook', x_coordinate: 0)
    else
      return pieces.find_by(game: self, \
                            color: color, type: 'Rook', x_coordinate: 7)
    end
  end

  # Set variables pointing at both pieces
  def select_rook_and_king(color, side)
    rook = which_rook(color, side)
    king = pieces.find_by(game: self, \
                          color: color, type: 'King')
    [rook, king]
  end
end
