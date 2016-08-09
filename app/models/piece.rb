# Piece model
class Piece < ActiveRecord::Base
  self.inheritance_column = :type

    def self.types
      %w(Queen King Bishop Rook Knight Pawn)
    end

    def self.change_position(x_coordinate, y_coordinate)
      self.x_coordinate = x_coordinate
      self.y_coordinate = y_coordinate
    end
end
