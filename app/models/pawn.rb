# Pawn model inheriting from Piece
class Pawn < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_pawn_range?(future_x, future_y)
  end

  # Returns true if the king is only moving from one block
  def valid_pawn_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_front?(x_diff, y_diff)
    false
  end

  private

  def find_diffs(future_x, future_y)
    if (future_y > y_coordinate) && color == 'black'
      x_diff = (x_coordinate - future_x).abs
      y_diff = (y_coordinate - 0).abs
    elsif (future_y < y_coordinate) && color == 'white'
      x_diff = (x_coordinate - future_x).abs
      y_diff = (y_coordinate - 0).abs
    else
      x_diff = (x_coordinate - future_x).abs
      y_diff = (y_coordinate - future_y).abs
    end
    [x_diff, y_diff]
  end

  def move_front?(x_diff, y_diff)
    return true if double_jump_black?(x_diff, y_diff)
    return true if double_jump_white?(x_diff, y_diff)
    return true if x_diff.zero? && y_diff == 1
    false
  end

  def double_jump_black?(x_diff, y_diff)
    if color == 'black' && y_coordinate == 6
      return true if x_diff.zero? && y_diff == 1 || y_diff == 2
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
end
