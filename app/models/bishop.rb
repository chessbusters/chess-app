# Bishop model inheriting from Piece
class Bishop < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_bishop_range?(future_x, future_y)
  end

  def valid_bishop_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_diag?(x_diff, y_diff)
  end

  private

  def find_diffs(future_x, future_y)
    x_diff = x_coordinate - future_x
    y_diff = y_coordinate - future_y
    [x_diff, y_diff]
  end

  def move_diag?(x_diff, y_diff)
    return true if x_diff.nonzero? && y_diff.nonzero? && x_diff.abs == y_diff.abs
  end
end
