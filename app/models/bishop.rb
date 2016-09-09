# Bishop model inheriting from Piece
class Bishop < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_bishop_range?(future_x, future_y)
  end

  def move_to!(new_x, new_y)
    potential_move = game.pieces.find_by(x_coordinate: new_x, y_coordinate: new_y)
    return raise 'Illegal move.' if !potential_move.nil? && color == potential_move.color
    potential_piece.destroy unless potential_move.nil?
    update_attributes(x_coordinate: new_x, y_coordinate: new_y)
  end

  def valid_bishop_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_diag?(x_diff, y_diff)
  end

  private

  def find_diffs(future_x, future_y)
    x_diff = (x_coordinate - future_x).abs
    y_diff = (y_coordinate - future_y).abs
    [x_diff, y_diff]
  end

  def move_diag?(x_diff, y_diff)
    return true if x_diff.nonzero? && y_diff.nonzero? && x_diff == y_diff
  end
end
