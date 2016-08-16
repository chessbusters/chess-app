# King model inheriting from Piece
class King < Piece
  def valid_move?(future_x, future_y)
    !self.obstructed?(future_x, future_y) && valid_king_range?(future_x, future_y)
  end

# Returns true if the king is only moving from one block
  def valid_king_range?(future_x, future_y) # 2 , 4 -> 4, 4
    if (self.x_coordinate - future_x).abs == 1 && (self.y_coordinate - future_y).abs == 1
      return true
    else 
      if (self.x_coordinate - future_x).abs == 1 && (self.y_coordinate - future_y).abs == 0
        return true
      elsif (self.x_coordinate - future_x).abs == 0 && (self.y_coordinate - future_y).abs == 1
        return true
      end
    end
    false
  end
end
