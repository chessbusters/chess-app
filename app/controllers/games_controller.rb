class GamesController < ApplicationController

  def index

  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    if @game.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

end
