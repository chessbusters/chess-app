# Pawn model inheriting from Piece
class Pawn < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_pawn_range?(future_x, future_y)
  end

  # Returns true if the pawn is only moving from one block
  def valid_pawn_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if check_move?(x_diff, y_diff)
    return true if eat_diag?(x_diff, y_diff) && !game.pieces.find_by(x_coordinate: future_x, \
                                         y_coordinate: future_y).nil?
    false
  end


  def find_diffs(future_x, future_y)
    x_diff = x_coordinate - future_x
    y_diff = y_coordinate - future_y
    [x_diff, y_diff]
  end

  def eat_diag?(x_diff, y_diff)
    if color = 'black'
      return true if (x_diff == 1 || x_diff == -1) && y_diff == 1
    else
      return true if (x_diff == 1 || x_diff == -1) && y_diff == -1
    end
    false
  end

  def check_move?(x_diff, y_diff)
    return true if double_jump_black?(x_diff, y_diff)
    return true if double_jump_white?(x_diff, y_diff)
    return true if move_forward?(x_diff, y_diff)
    false
  end

  def double_jump_black?(x_diff, y_diff)
    if color == 'black' && y_coordinate == 6
      return true if x_diff.zero? && y_diff == 2
    else
      false
    end
  end

  def double_jump_white?(x_diff, y_diff)
    if color == 'white' && y_coordinate == 1
      return true if x_diff.zero? && y_diff == -2
    else
      false
    end
  end

  def move_forward?(x_diff, y_diff)
    if color == 'white'
      return true if x_diff.zero? && y_diff == -1
    else
      return true if x_diff.zero? && y_diff == 1
    end
    false
  end

end
