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
    @game = Game.new(game_params)
     respond_to do |format|
    if @game.save
      @game.update(white_user_id: current_user[:id])
      format.html { redirect_to @game, notice: 'Project was successfully created.' }

      format.json { render json: Game.all.order(:name)}
    else
      format.html {render :new}
    end
  end
  end

  def update
    @game = Game.find(params[:id])
    @piece = Piece.find(params[:piece_id])
    if @piece.valid_move?(params[:x_coordinate].to_i, params[:y_coordinate].to_i)
      @piece.move_to!(params[:x_coordinate], params[:y_coordinate])
      flash[:notice] = 'Moved'
    else
      flash[:alert] = 'Invalid Move'
    end
    Pusher.trigger("channel-#{@game.id}", 'update-piece', foo: 'bar')
    render text: 'updated!'
  end

  def show


    @game = Game.find(params[:id])
    @pieces = Piece.where(game: @game)
    user_select(@game)
    @board = Array.new(8) { Array.new(8) }
    8.times.with_index do |_row, row_index|
      8.times.with_index do |_col, col_index|
        piece = Piece.where(game: @game, x_coordinate: row_index,\
                            y_coordinate: col_index).first
        if piece
          if piece.color == 'white'
            case piece.type
            when 'Pawn'
              @board[row_index][col_index] = "\u2659"
            when 'Rook'
              @board[row_index][col_index] = "\u2656"
            when 'Knight'
              @board[row_index][col_index] = "\u2658"
            when 'Bishop'
              @board[row_index][col_index] = "\u2657"
            when 'King'
              @board[row_index][col_index] = "\u2654"
            when 'Queen'
              @board[row_index][col_index] = "\u2655"
            end
          else
            case piece.type
            when 'Pawn'
              @board[row_index][col_index] = "\u265F"
            when 'Rook'
              @board[row_index][col_index] = "\u265C"
            when 'Knight'
              @board[row_index][col_index] = "\u265E"
            when 'Bishop'
              @board[row_index][col_index] = "\u265D"
            when 'King'
              @board[row_index][col_index] = "\u265A"
            when 'Queen'
              @board[row_index][col_index] = "\u265B"
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

  def castling_move
  if current_game.valid_castling_move?(params[:color], params[:side])
  rook, king = current_game.select_rook_and_king(params[:color], params[:side])
  king.castle!(params[:color], params[:side]) && rook.castle!(params[:color], params[:side])
  show
  render :show
  end
end

  private

  def game_params
    params.require(:game).permit(:name, :white_castling, :black_castling)
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
