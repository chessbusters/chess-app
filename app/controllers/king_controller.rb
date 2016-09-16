class KingController < ApplicationController

  def update
  end

    private

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find(params[:id])
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:game_id])
  end

  def piece_params
    params.permit(:id, :user_id, :game_id, :x_coordinate,
                                   :y_coordinate, :type, :taken)
    # params.require(:piece).permit(:id, :user_id, :game_id, :x_coordinate,
    #                               :y_coordinate, :type, :taken)
  end
end
