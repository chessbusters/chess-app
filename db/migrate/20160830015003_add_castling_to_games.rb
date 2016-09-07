class AddCastlingToGames < ActiveRecord::Migration
  def change
    add_column :games, :white_castling, :string
    add_column :games, :black_castling, :string
  end
end
