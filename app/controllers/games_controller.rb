# Controller for app CRUD logic
class GamesController < ApplicationController
before_action :authenticate_user!

  def index
    @game = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(:white_user_id => current_user[:id] )
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
     @game = Game.find(params[:id])
    if @game.white_user_id == current_user[:id]
      redirect_to root_path, alert: "Need another oppenent than creator :O)"
      elsif @game.white_user_id != nil && @game.black_user_id == nil
      @game.black_user_id = current_user[:id]
    end
  end

  private

  def game_params
    params.require(:game).permit(:white_user_id)
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
