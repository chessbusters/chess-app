# Controller for pieces logic
class PiecesController < ApplicationController
  def index
    @piece = Piece.all
  end

  def show
    @piece = Piece.find(params[:id])
    @game = Game.find(params[:game_id])
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
  end

  def update
    @piece = Piece.find(params[:id])
    @game = Game.find(params[:game_id])
    @piece.move_to!(params[:x_coordinate], params[:y_coordinate])
    redirect_to game_path(@game)
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
