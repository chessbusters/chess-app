# model for games
class Game < ActiveRecord::Base
  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  has_many :pieces
  belongs_to :user
  delegate :bishops, :rooks, :pawns, :kings, :queens, :knights, to: :pieces
end
