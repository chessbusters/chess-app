# Pawn model inheriting from Piece
class Pawn < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_pawn_range?(future_x, future_y)
  end

  # Returns true if the pawn is only moving from one block
  def valid_pawn_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_forward?(x_diff, y_diff)
    false
  end

  private

  def find_diffs(future_x, future_y)
    x_diff = future_x - x_coordinate
    y_diff = future_y - y_coordinate
    [x_diff, y_diff]
  end

  def move_forward?(x_diff, y_diff)
    return true if double_jump_black?(x_diff, y_diff)
    return true if double_jump_white?(x_diff, y_diff)
    return true if black_forward?(x_diff, y_diff)
    return true if white_forward?(x_diff, y_diff)
    false
  end

  def double_jump_black?(x_diff, y_diff)
    if color == 'black' && y_coordinate == 6
      return true if x_diff.zero? && y_diff == -1 || y_diff == -2
    else
      false
    end
  end

  def double_jump_white?(x_diff, y_diff)
    if color == 'white' && y_coordinate == 1
      return true if x_diff.zero? && y_diff == 1 || y_diff == 2
    else
      false
    end
  end

  def black_forward?(x_diff, y_diff)
    x_diff.zero? && (y_diff == -1 && color == 'black') ? true : false
  end

  def white_forward?(x_diff, y_diff)
    x_diff.zero? && (y_diff == 1 && color == 'white') ? true : false
  end
end
