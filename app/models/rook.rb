# Rook model inheriting from Piece
class Rook < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_rook_range?(future_x, future_y)
  end

  def valid_rook_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_horiz?(x_diff, y_diff)
    return true if move_vert?(x_diff, y_diff)
    false
  end

  def can_castle?(_rook_position)
    return true if queenside?
    return true if kingside?
    false
  end

  private

  def find_diffs(future_x, future_y)
    x_diff = future_x - x_coordinate
    y_diff = future_y - y_coordinate
    [x_diff, y_diff]
  end

  def move_horiz?(x_diff, y_diff)
    return true if x_diff.nonzero? && y_diff.zero?
  end

  def move_vert?(x_diff, y_diff)
    return true if x_diff.zero? && y_diff.nonzero?
  end

  def queenside?
    if color == 'black'
    end
  end
end
