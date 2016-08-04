class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|

      t.integer :user_id
      t.integer :game_id
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.string :type

      t.boolean :taken

      t.timestamps
    end
  end
end
