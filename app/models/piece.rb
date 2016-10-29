# Piece model
class Piece < ActiveRecord::Base
  belongs_to :game
  self.inheritance_column = :type

  scope :kings, -> { where(type: 'King') }
  scope :queens, -> { where(type: 'Queen') }
  scope :bishops, -> { where(type: 'Bishop') }
  scope :rooks, -> { where(type: 'Rook') }
  scope :knights, -> { where(type: 'Knight') }
  scope :pawns, -> { where(type: 'Pawn') }

  def self.types
    %w(Queen King Bishop Rook Knight Pawn)
  end

  def change_position(x_coordinate, y_coordinate)
    self.x_coordinate = x_coordinate
    self.y_coordinate = y_coordinate
  end

  # Checks whether or not a piece is obstructed from reaching a location by
  # another piece. Returns an error if a piece attempts to move irregularly.
  def obstructed?(future_x, future_y)
    return 'Invalid: not horizontal/vert/diag.' if invalid?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    if direction?(future_x, future_y) == 'diag'
      check_diagonal(future_x, x_diff)
    elsif direction?(future_x, future_y) == 'horiz'
      check_horizontal(future_x, x_diff)
    elsif direction?(future_x, future_y) == 'vert'
      check_vertical(future_y, y_diff)
    else false
    end
  end

  def find_diffs(future_x, future_y)
    x_diff = x_coordinate - future_x
    y_diff = y_coordinate - future_y
    [x_diff, y_diff]
  end

  def move_to!(new_x, new_y)
    potential_move = game.pieces.find_by(x_coordinate: new_x, \
                                         y_coordinate: new_y)
    return raise 'Illegal move.' if !potential_move.nil? && \
                                    color == potential_move.color
    potential_move.destroy unless potential_move.nil?
    update_attributes(x_coordinate: new_x, y_coordinate: new_y)
  end

  # set the new positions for king and rook after castling complete
  def new_positions(color, side)
    new_y = color == 'white' ? 0 : 7
    new_rook_x = side == 'king_side' ? 2 : 4
    new_king_x = side == 'king_side' ? 1 : 5
    [new_y, new_rook_x, new_king_x]
  end

  private

  # Determines if a move is not horizontal, vertical, or properly diagonal.
  def invalid?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if (x_diff != y_diff) && x_diff.nonzero? && y_diff.nonzero?
    false
  end

  # Figures out what direction the piece is trying to move.
  def direction?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return 'diag' if x_diff.nonzero? && y_diff.nonzero?
    return 'horiz' if y_diff.zero?
    return 'vert' if x_diff.zero?
  end

  # Finds out whether the index of the location where the piece is moving to is
  # higher or lower, then sets the range that needs to be checked appropriately
  def find_range(future_coord, current_coord, diff)
    if diff > 0
      (future_coord + 1...current_coord).to_a
    else
      (current_coord + 1...future_coord).to_a
    end
  end

  # Check for diagonal obstructions
  def check_diagonal(future_x, x_diff)
    range = find_range(future_x, x_coordinate, x_diff)
    range.each do |d|    
      return true if game.pieces.where(x_coordinate: d, y_coordinate: d, color: color).exists?
    end
    false
  end

  # Check for horizontal obstructions
  def check_horizontal(future_x, x_diff)
    range = find_range(future_x, x_coordinate, x_diff)
    range.each do |x|
      return true if \
      game.pieces.where(x_coordinate: x, y_coordinate: y_coordinate).exists? 
    end
    false
  end

  # Check for vertical obstructions
  def check_vertical(future_y, y_diff)
    range = find_range(future_y, y_coordinate, y_diff)
    range.each do |y|
      return true if \
      game.pieces.where(x_coordinate: x_coordinate, y_coordinate: y).exists?
    end
    false
  end
end
