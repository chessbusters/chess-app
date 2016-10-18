# King model inheriting from Piece
class King < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_king_range?(future_x, future_y) &&
      !future_check?(future_x, future_y)
  end

  # Returns true if the king is only moving from one block
  def valid_king_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_diag?(x_diff, y_diff)
    return true if move_horiz?(x_diff, y_diff)
    return true if move_vert?(x_diff, y_diff)
    false
  end

  def future_check?(future_x, future_y)
    opposing_pieces = Piece.where(game: self.game).where.not(color: self.color)
    opposing_pieces.each do |piece|
      return true if piece.valid_move?(future_x, future_y)
    end
    false
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
end
