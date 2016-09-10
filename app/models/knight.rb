# Knight model inheriting from Piece
class Knight < Piece
  def valid_move?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if x_diff == 2 && y_diff == 1
    return true if x_diff == 1 && y_diff == 2
    false
  end

  def find_diffs(future_x, future_y)
    x_diff = (x_coordinate - future_x).abs
    y_diff = (y_coordinate - future_y).abs
    [x_diff, y_diff]
  end
end
