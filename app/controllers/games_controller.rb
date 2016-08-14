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
    @game = Game.create(game_params)
    if @game.valid?
      @game.update(white_user_id: current_user[:id])
      redirect_to game_path(@game), 
      alert: "Invite your friend ! link to your game: http://localhost:3030/games/#{@game}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
     @game = Game.find(params[:id])
    if @game.white_user_id == current_user[:id]
      flash[:notice] = "Welcome back :)"
      elsif @game.white_user_id != nil && @game.black_user_id == nil
      @game.update(black_user_id: current_user[:id])
      # Generate the board and populate it with pieces 
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
