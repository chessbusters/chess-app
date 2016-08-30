# King model inheriting from Piece
class King < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_king_range?(future_x, future_y)
  end

  # Returns true if the king is only moving from one block
  def valid_king_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_diag?(x_diff, y_diff)
    return true if move_horiz?(x_diff, y_diff)
    return true if move_vert?(x_diff, y_diff)
    false
  end

  def move_to!(new_x, new_y)
    potential_piece = game.pieces.find_by(x_coordinate: new_x, y_coordinate: new_y)
    if potential_piece.nil? && valid_move?(new_x, new_y)
      cancel_castling
      return update_attributes(x_coordinate: new_x, \
                             y_coordinate: new_y)
    end
    return raise 'Illegal move.' if color == piece.color
    cancel_castling
    potential_piece.destroy
    update_attributes(x_coordinate: new_x, y_coordinate: new_y)
  end

  private

  def find_diffs(future_x, future_y)
    x_diff = (x_coordinate - future_x).abs
    y_diff = (y_coordinate - future_y).abs
    [x_diff, y_diff]
  end

  def move_horiz?(x_diff, y_diff)
    return true if x_diff == 1 && y_diff.zero?
  end

  def move_vert?(x_diff, y_diff)
    return true if x_diff.zero? && y_diff == 1
  end

  def move_diag?(x_diff, y_diff)
    return true if x_diff == 1 && y_diff == 1
  end

  def cancel_castling
    color == "white" ? game.white_castling = false : game.black_castling = false
  end
end
