# King model inheriting from Piece
class King < Piece

  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_king_range?(future_x, future_y)
  end

  # Returns true if the king is only moving from one block
  def valid_king_range?(future_x, future_y)
    x_diff_king, y_diff_king = find_diffs_king(future_x, future_y)
    return true if move_diag?(x_diff_king, y_diff_king)
    return true if move_horiz?(x_diff_king, y_diff_king)
    return true if move_vert?(x_diff_king, y_diff_king)
    false
  end

  def castle!(color, side)
    new_y, new_rook_x, new_king_x = new_positions(color, side)
    if game.valid_castling_move?(color, side)
    update_attributes(x_coordinate: new_king_x, y_coordinate: new_y)
    end
  end

  private

  def find_diffs_king(future_x, future_y)
    x_diff_king = (x_coordinate - future_x).abs
    y_diff_king = (y_coordinate - future_y).abs
    [x_diff_king, y_diff_king]
  end

  def move_horiz?(x_diff_king, y_diff_king)
    return true if x_diff_king == 1 && y_diff_king.zero?
  end

  def move_vert?(x_diff_king, y_diff_king)
    return true if x_diff_king.zero? && y_diff_king == 1
  end

  def move_diag?(x_diff_king, y_diff_king)
    return true if x_diff_king == 1 && y_diff_king == 1
  end

end
