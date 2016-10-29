# Queen model inheriting from Piece
class Queen < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_queen_range?(future_x, future_y)
  end

  # Returns true if the king is only moving from one block
  def valid_queen_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_diag?(x_diff, y_diff)
    return true if move_horiz?(x_diff, y_diff)
    return true if move_vert?(x_diff, y_diff)
    false
  end

  private

  def find_diffs(future_x, future_y)
    x_diff = (x_coordinate - future_x).abs
    y_diff = (y_coordinate - future_y).abs
    [x_diff, y_diff]
  end

  def move_horiz?(x_diff, y_diff)
    return true if x_diff.nonzero? && y_diff.zero?
  end

  def move_vert?(x_diff, y_diff)
    return true if x_diff.zero? && y_diff.nonzero?
  end

  def move_diag?(x_diff, y_diff)
    return true if x_diff.nonzero? && y_diff.nonzero? && x_diff == y_diff
  end
end
