# Piece model
class Piece < ActiveRecord::Base
  belongs_to :game
  self.inheritance_column = :type

  scope :kings, -> { where(type: 'King') }
  scope :queens, -> { where(type: 'Queen') }
  scope :bishops, -> { where(type: 'Bishop') }
  scope :rooks, -> { where(type: 'Rook') }
  scope :knights, -> { where(type: 'Knight') }
  scope :pawns, -> { where(type: 'Pawn') }

  def self.types
    %w(Queen King Bishop Rook Knight Pawn)
  end

  def self.change_position(x_coordinate, y_coordinate)
    self.x_coordinate = x_coordinate
    self.y_coordinate = y_coordinate
  end
end
