class AddCastlingToGames < ActiveRecord::Migration
  def change
    add_column :games, :white_castling, :boolean, default: true
    add_column :games, :black_castling, :boolean, default: true
  end
end
