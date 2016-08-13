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
  
  def is_obstructed?(future_x, future_y)
    x_diff = self.x_coordinate - future_x
    y_diff = self.y_coordinate - future_y
    return "Invalid Input: Not diagonal, horizontal, or vertical." if (x_diff != y_diff) && x_diff != 0 && y_diff != 0
    
    #Check for diagonal obstructions
    if x_diff != 0 && y_diff != 0
      if x_diff > 0
        (future_x + 1 ... self.x_coordinate).each do |d|
          if game.pieces.where(x_coordinate: d, y_coordinate: d).exists?
            return true
          end
        end
      else
        (self.x_coordinate + 1 ... future_x).each do |d|
          if game.pieces.where(x_coordinate: d, y_coordinate: d).exists?
            return true
          end
        end
      end 
    end
    
    #Check for horizontal obstructions
    if y_diff == 0
      if x_diff > 0
        (future_x + 1 ... self.x_coordinate).each do |x|
          if game.pieces.where(x_coordinate: x, y_coordinate: self.y_coordinate).exists?
            return true
          end
        end
      else
        (self.x_coordinate + 1 ... future_x).each do |x|
          if game.pieces.where(x_coordinate: x, y_coordinate: self.y_coordinate).exists?
            return true
          end
        end
      end
    end
    
    #Check for vertical obstructions
    if x_diff == 0
      if y_diff > 0
        (future_y + 1 ... self.y_coordinate).each do |y|
          if game.pieces.where(x_coordinate: self.x_coordinate, y_coordinate: y).exists?
            return true
          end
        end
      else
        (self.y_coordinate + 1 ... future_y).each do |y|
          if game.pieces.where(x_coordinate: self.x_coordinate, y_coordinate: y).exists?
            return true
          end
        end
      end
    end
    
    return false
  end
  
end
