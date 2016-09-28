class AddCastlingToGames < ActiveRecord::Migration
  def change
    add_column :games, :white_castling, :boolean, default: false
    add_column :games, :black_castling, :boolean, default: false
  end
end
