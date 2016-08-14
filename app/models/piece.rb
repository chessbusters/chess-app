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

  def obstructed?(future_x, future_y)
    x_diff = x_coordinate - future_x
    y_diff = y_coordinate - future_y
    return 'Invalid Input: Not diagonal, horizontal, or vertical.' if (x_diff != y_diff) && x_diff.nonzero? && y_diff.nonzero?
    if x_diff.nonzero? && y_diff.nonzero?
      return true if check_diagonal(future_x) == true
    elsif y_diff.zero?
      return true if check_horizontal(future_x) == true
    else
      return true if check_vertical(future_y) == true
    end
    return false
  end

  # Check for diagonal obstructions
  def check_diagonal(future_x)
    x_diff = x_coordinate - future_x
    if x_diff > 0
      (future_x + 1...x_coordinate).each do |d|
        return true if game.pieces.where(x_coordinate: d, y_coordinate: d).exists?
      end
    else
      (x_coordinate + 1...future_x).each do |d|
        return true if game.pieces.where(x_coordinate: d, y_coordinate: d).exists?
      end
    end
  end

  # Check for horizontal obstructions
  def check_horizontal(future_x)
    x_diff = x_coordinate - future_x
    if x_diff > 0
      (future_x + 1...x_coordinate).each do |x|
        return true if game.pieces.where(x_coordinate: x, y_coordinate: y_coordinate).exists?
      end
    else
      (x_coordinate + 1...future_x).each do |x|
        return true if game.pieces.where(x_coordinate: x, y_coordinate: y_coordinate).exists?
      end
    end
  end

  # Check for vertical obstructions
  def check_vertical(future_y)
    y_diff = y_coordinate - future_y
    if y_diff > 0
      (future_y + 1...y_coordinate).each do |y|
        return true if game.pieces.where(x_coordinate: x_coordinate, y_coordinate: y).exists?
      end
    else
      (y_coordinate + 1...future_y).each do |y|
        return true if game.pieces.where(x_coordinate: x_coordinate, y_coordinate: y).exists?
      end
    end
  end
end
