class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :white_games, class_name: 'Game', foreign_key: "white_user_id"
  has_many :black_games, class_name: 'Game', foreign_key: "black_user_id"
end
