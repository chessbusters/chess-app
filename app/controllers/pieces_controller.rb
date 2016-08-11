# Controller for pieces logic
class PiecesController < ApplicationController
  def index
    @piece = Piece.all
  end

  def show
  end

  def update
  end

  private

  def piece_params
    params.require(:piece).permit(:id, :user_id, :game_id, :x_coordinate,
                                  :y_coordinate, :type, :taken)
  end
end
