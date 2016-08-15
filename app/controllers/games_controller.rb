# Controller for app CRUD logic
class GamesController < ApplicationController
  def index
    @game = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.valid?
      @game.update(white_user_id: current_user[:id])
      redirect_to game_path(@game),
                  alert: "Invite your friend !
                  http://localhost:3030/games/#{@game}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @game = Game.find(params[:id])
    user_select(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def user_select(_game)
    if @game.white_user_id == current_user[:id]
      flash[:notice] = 'Welcome back :)'
    elsif !@game.white_user_id.nil? && @game.black_user_id.nil?
      @game.update(black_user_id: current_user[:id])
      # Generate the board and populate it with pieces
    end
  end
end
