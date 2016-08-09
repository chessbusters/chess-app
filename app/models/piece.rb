# Piece model
class Piece < ActiveRecord::Base
  self.inheritance_column = :p_type

  def self.p_types
    %w(Queen King Bishop Rook Knight Pawn)
  end

  def self.change_position(x_coordinate, y_coordinate)
    self.x_coordinate = x_coordinate
    self.y_coordinate = y_coordinate
  end
end
