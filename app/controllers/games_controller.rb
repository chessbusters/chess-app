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
                  alert: "Invite your friend !
                  http://localhost:3030/games/#{@game}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show


    @game = Game.find(params[:id])
    user_select(@game)
    @pieces = Array.new(8) { Array.new(8) }
    8.times.with_index do |_row, row_index|
      8.times.with_index do |_col, col_index|
        piece = Piece.where(game: @game, x_coordinate: row_index,\
                            y_coordinate: col_index).first
        if piece
          if piece.color == 'white'
            case piece.type
            when 'Pawn'
              @pieces[row_index][col_index] = "\u2659"
            when 'Rook'
              @pieces[row_index][col_index] = "\u2656"
            when 'Knight'
              @pieces[row_index][col_index] = "\u2658"
            when 'Bishop'
              @pieces[row_index][col_index] = "\u2657"
            when 'King'
              @pieces[row_index][col_index] = "\u2654"
            when 'Queen'
              @pieces[row_index][col_index] = "\u2655"
            end
          else
            case piece.type
            when 'Pawn'
              @pieces[row_index][col_index] = "\u265F"
            when 'Rook'
              @pieces[row_index][col_index] = "\u265C"
            when 'Knight'
              @pieces[row_index][col_index] = "\u265E"
            when 'Bishop'
              @pieces[row_index][col_index] = "\u265D"
            when 'King'
              @pieces[row_index][col_index] = "\u265A"
            when 'Queen'
              @pieces[row_index][col_index] = "\u265B"
            end
          end
        end
      end
    end
  
    if @game.check?('white')
      flash[:notice] = "White king is in check"
    elsif @game.check?('black')
      flash[:notice] = "Black king is in check"
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

  def user_select(_game)
    if @game.white_user_id == current_user[:id]
      flash[:notice] = 'Welcome back :)'
    elsif !@game.white_user_id.nil? && @game.black_user_id.nil?
      @game.update(black_user_id: current_user[:id])
      # Generate the board and populate it with pieces
    end
  end
end
