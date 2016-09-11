# Rook model inheriting from Piece
class Rook < Piece
  def valid_move?(future_x, future_y)
    !obstructed?(future_x, future_y) && valid_rook_range?(future_x, future_y)
  end

  def move_to!(new_x, new_y)
    potential_move = game.pieces.find_by(x_coordinate: new_x, \
                                         y_coordinate: new_y)
    return raise 'Illegal move.' if !potential_move.nil? && \
                                    color == potential_move.color
    potential_move.destroy unless potential_move.nil?
    update_attributes(x_coordinate: new_x, y_coordinate: new_y)
  end

  def valid_rook_range?(future_x, future_y)
    x_diff, y_diff = find_diffs(future_x, future_y)
    return true if move_horiz?(x_diff, y_diff)
    return true if move_vert?(x_diff, y_diff)
    false
  end

  def castle!(color, side)
    new_y, new_rook_x, _new_king_x = new_positions(color, side)
    if game.valid_castling_move?(color, side)
      update_attributes(x_coordinate: new_rook_x, y_coordinate: new_y)
    end
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
end
